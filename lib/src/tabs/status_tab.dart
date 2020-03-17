import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/models/status_list.dart';
import 'package:flutter_whatsapp/src/widgets/status_item.dart';

class StatusTab extends StatelessWidget {

  final String searchKeyword;
  final Future<dynamic> statusList;
  final refresh;

  StatusTab({
    this.statusList,
    this.searchKeyword,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: statusList,
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
            List<dynamic> data = new List<dynamic>();
            data.add(StatusItem(
              title: 'My Status',
              subtitle: 'Tap to add status update',
              thumbnail: 'https://api.adorable.io/avatars/285/circle@adorable.png',
              onTap: (){
                Application.router.navigateTo(
                  context,
                  Routes.newStatus,
                  transition: TransitionType.inFromRight,
                );
              },
            ));
            data.addAll(_statusList.statuses);
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                if(i == 0) {
                  return data[i];
                }
                if (searchKeyword.isNotEmpty) {
                  if (!data[i].name
                      .toLowerCase()
                      .contains(searchKeyword.toLowerCase())) {
                    if (!isFound && i >= data.length - 1) {
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
                  status: data[i],
                  searchKeyword: searchKeyword,
                  onTap: () {
                    Application.router.navigateTo(
                      context,
                      "/status?id=${data[i].id}",
                      transition: TransitionType.inFromRight,
                    );
                  },
                );
              },
            );
        }
        return null; // unreachable
      },
    );
  }
}