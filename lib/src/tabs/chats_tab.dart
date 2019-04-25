import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/models/chat_list.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:flutter_whatsapp/src/screens/detail_chat_screen.dart';
import 'package:flutter_whatsapp/src/services/chat_service.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:flutter_whatsapp/src/widgets/chat_item.dart';

class ChatsTab extends StatefulWidget {
  TextEditingController _searchBarController;

  ChatsTab(this._searchBarController);

  @override
  _ChatsTab createState() => _ChatsTab();
}

class _ChatsTab extends State<ChatsTab>
    with AutomaticKeepAliveClientMixin<ChatsTab> {
  @override
  bool get wantKeepAlive => true;

  Future<ChatList> _chatList;
  ChatList _shownChatList;
  String _searchKeyword = "";

  @override
  void initState() {
    _shownChatList = new ChatList();
    _chatList = ChatService.getChats();
    super.initState();
    widget._searchBarController.addListener(() {
      setState(() {
        _searchKeyword = widget._searchBarController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<ChatList>(
      future: _chatList,
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
                child: Text('Couldn\'t connect to Internet.'),
              );
            }
            _shownChatList = snapshot.data;
            bool isFound = false;
            return ListView.builder(
                itemCount: _shownChatList.chats.length,
                itemBuilder: (context, i) {
                  if (_searchKeyword.isNotEmpty) {
                    if (!_shownChatList.chats[i].name
                        .toLowerCase()
                        .contains(_searchKeyword.toLowerCase())) {
                      if (!isFound && i >= _shownChatList.chats.length - 1) {
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
                  return _buildChatItem(
                      context, _searchKeyword, _shownChatList.chats[i]);
                });
        }
        return null; // unreachable
      },
    );
  }

  Widget _buildChatItem(BuildContext context, _searchKeyword, Chat chat) {
    return ChatItem(
      chat: chat,
      searchKeyword: _searchKeyword,
      iconSubtitle: _getIconSubtitle(chat),
      onTapProfile: () => onTapProfileChatItem(chat),
      onTap: () => onTapChatItem(context, chat)
    );
  }

  Icon _getIconSubtitle(Chat chat) {
    if(!chat.lastMessage.isYou) return null;

    if(chat.lastMessage.isRead) {
      return new Icon(Icons.done_all, color: blueCheckColor, size: 16.0,);
    }
    else {
      return new Icon(Icons.done_all, color: Colors.grey, size: 16.0,);
    }
  }

  void onTapChatItem(BuildContext context, Chat chat) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return DetailChatScreen(
              chat: chat,
          );
        }
    ));
  }

  void onTapProfileChatItem(Chat chat) {
    Dialog profileDialog = DialogHelpers.getProfileDialog(
        context: context,
      imageUrl: chat.avatarUrl,
      name: chat.name,
      onTapMessage: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailChatScreen(
                chat: chat,
              );
            }
        ));
      }
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => profileDialog
    );
  }
}
