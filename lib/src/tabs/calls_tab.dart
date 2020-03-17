import 'package:async/async.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/models/call_list.dart';
import 'package:flutter_whatsapp/src/services/call_service.dart';
import 'package:flutter_whatsapp/src/widgets/call_item.dart';

class CallsTab extends StatelessWidget {

  final String searchKeyword;
  final AsyncMemoizer memoizer;
  final refresh;

  CallsTab({
    this.memoizer,
    this.searchKeyword,
    this.refresh,
  });

  _getCallList() {
    return memoizer.runOnce(() {
      return CallService.getCalls();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCallList(),
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
            CallList _callList = snapshot.data;
            return ListView.builder(
              itemCount: _callList.calls.length,
              itemBuilder: (context, i) {
                if (searchKeyword.isNotEmpty) {
                  if (!_callList.calls[i].name
                      .toLowerCase()
                      .contains(searchKeyword.toLowerCase())) {
                    if (!isFound && i >= _callList.calls.length - 1) {
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
                return CallItem(
                  call: _callList.calls[i],
                  searchKeyword: searchKeyword,
                  onTap: (){
                    Application.router.navigateTo(
                      context,
                      "/call?id=${_callList.calls[i]}",
                      transition: TransitionType.inFromRight,
                    );
                  },
                  onProfileTap: () {
                    Dialog profileDialog = DialogHelpers.getProfileDialog(
                      context: context,
                      id: _callList.calls[i].id,
                      imageUrl: _callList.calls[i].avatarUrl,
                      name: _callList.calls[i].name,
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => profileDialog
                    );
                  },
                  onLeadingTap: () {
                    Scaffold.of(context).showSnackBar(
                      new SnackBar(content: Text('Calling ${_callList.calls[i].name}...'))
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