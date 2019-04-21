import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/textHelper.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  Chat chat;
  String searchKeyword;
  Icon iconSubtitle;
  var onTapProfile;
  var onTap;

  ChatItem(
      {this.chat,
      this.searchKeyword,
      this.iconSubtitle,
      this.onTapProfile,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      leading: GestureDetector(
        onTap: () {
          onTapProfile();
        },
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(chat.avatarUrl),
        ),
      ),
      title: searchKeyword == null || searchKeyword.isEmpty
          ? Text(
              chat.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : getHighlightedText(
              chat.name,
              searchKeyword,
              TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )),
      subtitle: Row(
        children: <Widget>[
          iconSubtitle == null ? Container() : Padding(padding: EdgeInsets.only(right: 2.0),child: iconSubtitle),
          Text(
            chat.lastMessage.content,
            maxLines: 1,
          ),
        ],
      ),
      trailing: Text(
        new DateFormat('dd/MM/yy').format(chat.lastMessage.timestamp),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
      onTap: onTap,
    );
  }
}
