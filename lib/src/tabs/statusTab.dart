import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/statusList.dart';
import 'package:flutter_whatsapp/src/services/statusService.dart';
import 'package:flutter_whatsapp/src/widgets/statusItem.dart';

class StatusTab extends StatefulWidget {

  TextEditingController _searchBarController;

  StatusTab(this._searchBarController);

  @override
  _StatusTab createState() => _StatusTab();
}

class _StatusTab extends State<StatusTab>
    with AutomaticKeepAliveClientMixin<StatusTab> {
  @override
  bool get wantKeepAlive => true;

  StatusList _statusList;
  Future<StatusList> _mStatusList;
  String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _mStatusList = getStatuses().then((statusList) {
      setState(() {
        _statusList = statusList;
      });
    });
    widget._searchBarController.addListener(() {
      setState(() {
        _searchKeyword = widget._searchBarController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatusList>(
      future: _mStatusList,
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
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            bool isFound = false;
            return ListView.builder(
              itemCount: _statusList.statuses.length,
              itemBuilder: (context, i) {
                if (_searchKeyword.isNotEmpty) {
                  if (!_statusList.statuses[i].name
                      .toLowerCase()
                      .contains(_searchKeyword.toLowerCase())) {
                    if (!isFound && i >= _statusList.statuses.length - 1) {
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                                'No results found for \'$_searchKeyword\''),
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
                  searchKeyword: _searchKeyword,
                );
              },
            );
        }
        return null; // unreachable
      },
    );
  }
}
