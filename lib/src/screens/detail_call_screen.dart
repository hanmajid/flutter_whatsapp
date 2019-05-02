import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/models/call.dart';
import 'package:flutter_whatsapp/src/models/call_detail.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:intl/intl.dart';

enum CallDetailOptions {
  removeLog,
  block
}

class DetailCallScreen extends StatefulWidget {

  final int id;

  DetailCallScreen({
    this.id,
  });

    _DetailCallScreen createState() => _DetailCallScreen();
}

class _DetailCallScreen extends State<DetailCallScreen> {
  @override
  Widget build(BuildContext context) {
    Call call = new Call(
      name: 'NAME',
      avatarUrl: 'https://via.placeholder.com/100x100',
      callDetails: <CallDetail>[
        new CallDetail(
          timestamp: DateTime.now(),
          isMissed: true,
          isIncoming: true,
        )
      ]
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Call info'),
        actions: <Widget>[
          IconButton(
            tooltip: 'New chat',
            icon: Icon(Icons.message),
            onPressed: (){},
          ),
          PopupMenuButton<CallDetailOptions>(
            tooltip: 'More options',
            onSelected: _onSelectedOption,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<CallDetailOptions>(
                  child: Text('Remove from call log'),
                  value: CallDetailOptions.removeLog,
                ),
                PopupMenuItem<CallDetailOptions>(
                  child: Text('Block'),
                  value: CallDetailOptions.block,
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Dialog profileDialog = DialogHelpers.getProfileDialog(
                            context: context,
                            id: 1,
                            imageUrl: call.avatarUrl,
                            name: call.name,
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => profileDialog
                          );
                        },
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(call.avatarUrl),
                        ),
                      );
                    }
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        call.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    color: Theme.of(context).primaryColor,
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    color: Theme.of(context).primaryColor,
                    onPressed: (){},
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 14.0, left: 14.0, top: 16.0),
                  child: Text(
                    new DateFormat('MMMM dd').format(call.lastCall.timestamp),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: secondaryColor,
                    ),
                  ),
                ),
                Divider(),
                _buildCallDetails(call),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCallDetails(Call call) {
    List<Widget> callDetails = new List<Widget>();

    for(CallDetail detail in call.callDetails.reversed.toList()) {
      callDetails.add(new Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              detail.isIncoming ? Icons.call_received : Icons.call_made,
              color: detail.isMissed ? Colors.red : Colors.green,
              size: 20.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  detail.isMissed ? 'Missed' : (detail.isIncoming ? 'Incoming' : 'Outgoing'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  new DateFormat('HH:mm').format(detail.timestamp),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ));
    }

    return Column(
      children: callDetails,
    );
  }

  _onSelectedOption(CallDetailOptions option) {
    switch(option) {
      case CallDetailOptions.removeLog:
        break;
      case CallDetailOptions.block:
        break;
    }
  }
}