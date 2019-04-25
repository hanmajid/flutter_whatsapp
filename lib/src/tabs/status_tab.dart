import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/status_list.dart';
import 'package:flutter_whatsapp/src/services/status_service.dart';
import 'package:flutter_whatsapp/src/widgets/status_item.dart';

class StatusTab extends StatelessWidget {

  final String searchKeyword;
  final AsyncMemoizer memoizer;
  final refresh;

  StatusTab({
    this.memoizer,
    this.searchKeyword,
    this.refresh,
  });

  _getStatusList() {
    return memoizer.runOnce(() async {
      return StatusService.getStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getStatusList(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Error: ${snapshot.error}', textAlign: TextAlign.center,),
                    RaisedButton(
                      child: Text('Refresh'),
                      onPressed: refresh,
                    )
                  ]
              );
            }
            bool isFound = false;
            StatusList _statusList = snapshot.data;
            return ListView.builder(
              itemCount: _statusList.statuses.length,
              itemBuilder: (context, i) {
                if (searchKeyword.isNotEmpty) {
                  if (!_statusList.statuses[i].name
                      .toLowerCase()
                      .contains(searchKeyword.toLowerCase())) {
                    if (!isFound && i >= _statusList.statuses.length - 1) {
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                                'No results found for \'$searchKeyword\''),
                          ));
                    }
                    return SizedBox(
                      height: 0.0,
                    );
                  }
                }
                isFound = true;
                return StatusItem(
                  status: _statusList.statuses[i],
                  searchKeyword: searchKeyword,
                );
              },
            );
        }
        return null; // unreachable
      },
    );
  }
}