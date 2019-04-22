import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/call_list.dart';
import 'package:flutter_whatsapp/src/services/call_service.dart';
import 'package:flutter_whatsapp/src/widgets/call_item.dart';

class CallsTab extends StatefulWidget {
  
  final TextEditingController searchBarController;
  
  CallsTab(this.searchBarController);
  
  _CallsTab createState() => _CallsTab();
}

class _CallsTab extends State<CallsTab> with AutomaticKeepAliveClientMixin<CallsTab> {

  @override
  bool get wantKeepAlive => true;
  
  String _searchKeyword = '';
  Future<CallList> _fCallList;
  CallList _callList;
  
  @override
  void initState() {
    super.initState();
    _fCallList = getCalls().then((callList) {
      setState(() {
        _callList = callList;
      });
    });
    widget.searchBarController.addListener(_onChangeSearchBar);
  }
  
  @override
  void dispose() {
    widget.searchBarController.removeListener(_onChangeSearchBar);
    super.dispose();
  }

  void _onChangeSearchBar() {
    setState(() {
      _searchKeyword = widget.searchBarController.text;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fCallList,
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
              itemCount: _callList.calls.length,
              itemBuilder: (context, i) {
                if (_searchKeyword.isNotEmpty) {
                  if (!_callList.calls[i].name
                      .toLowerCase()
                      .contains(_searchKeyword.toLowerCase())) {
                    if (!isFound && i >= _callList.calls.length - 1) {
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
                return CallItem(
                  call: _callList.calls[i],
                  searchKeyword: _searchKeyword,
                  onTap: (){},
                  onProfileTap: (){},
                );
              },
            );
        }
        return null; // unreachable
      },
    );
  }
  
}