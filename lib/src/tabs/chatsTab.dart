import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/chatList.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:flutter_whatsapp/src/services/chatService.dart';
import 'package:flutter_whatsapp/src/widgets/chatItem.dart';

class ChatsTab extends StatefulWidget {
  @override
  _ChatsTab createState() => _ChatsTab();
}

class _ChatsTab extends State<ChatsTab> with AutomaticKeepAliveClientMixin<ChatsTab> {

  @override
  bool get wantKeepAlive => true;

  Future<ChatList>_chatList;

  @override
  void initState() {
    _chatList = getChats();
    super.initState();
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
            return ListView.builder(
                itemCount: snapshot.data.chats.length,
                itemBuilder: (context2, i) {
                  return _buildChatItem(context2, snapshot.data.chats[i]);
                });
        }
        return null; // unreachable
      },
    );
  }

  Widget _buildChatItem(BuildContext context, Chat chat) {
    return ChatItem(chat, () => onTapChatItem(context, chat));
  }

  static onTapChatItem(BuildContext context, Chat chat) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: Text("You clicked: ${chat.name}")));
  }
}
