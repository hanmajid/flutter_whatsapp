import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {

  Chat _chat;
  var _onTap;

  ChatItem(this._chat, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(this._chat.avatarUrl),
      ),
      title: Text(
        this._chat.name,
        maxLines: 1,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        this._chat.lastMessage.content,
        maxLines: 1,
      ),
      trailing: Text(
        new DateFormat('dd/MM/yy').format(this._chat.lastMessage.timestamp),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
      onTap: this._onTap,
    );
  }

}