import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/statusList.dart';
import 'package:flutter_whatsapp/src/services/statusService.dart';
import 'package:flutter_whatsapp/src/widgets/statusItem.dart';

class StatusTab extends StatefulWidget {
  @override
  _StatusTab createState() => _StatusTab();
}

class _StatusTab extends State<StatusTab>
    with AutomaticKeepAliveClientMixin<StatusTab> {
  @override
  bool get wantKeepAlive => true;

  StatusList _statusList;
  Future<StatusList> _mStatusList;

  @override
  void initState() {
    super.initState();
    _mStatusList = getStatuses().then((statusList) {
      setState(() {
        _statusList = statusList;
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
            return ListView.builder(
              itemCount: _statusList.statuses.length,
              itemBuilder: (context, i) {
                return StatusItem(
                  name: _statusList.statuses[i].name,
                  timestamp: _statusList.statuses[i].timestamp,
                  thumbnailUrl: _statusList.statuses[i].thumbnailUrl,
                  isSeen: _statusList.statuses[i].isSeen,
                );
              },
            );
        }
        return null; // unreachable
      },
    );
  }
}
