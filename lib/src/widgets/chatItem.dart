import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  Chat _chat;
  String _searchKeyword;
  var _onProfileTap;
  var _onTap;

  ChatItem(this._chat, this._searchKeyword, this._onProfileTap, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
//      leading: Container(
//          child: ConstrainedBox(
//            constraints: BoxConstraints.expand(),
//            child: FlatButton(
//              onPressed: null,
//              padding: EdgeInsets.all(0.0),
//              child: CircleAvatar(
//                radius: 30.0,
//                backgroundImage: NetworkImage(_chat.avatarUrl),
//              )
//            )
//          )
//      ),
      leading: GestureDetector(
        onTap: () {
          _onProfileTap();
        },
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(_chat.avatarUrl),
        ),
      ),
      title: _searchKeyword == null || _searchKeyword.isEmpty
          ? Text(
              _chat.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : _getHighlightedName(
              _chat.name,
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
      subtitle: Text(
        _chat.lastMessage.content,
        maxLines: 1,
      ),
      trailing: Text(
        new DateFormat('dd/MM/yy').format(_chat.lastMessage.timestamp),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
      onTap: _onTap,
    );
  }

  RichText _getHighlightedName(
      String text, TextStyle normalStyle, TextStyle highlightStyle) {
    int index = text.toLowerCase().indexOf(_searchKeyword.toLowerCase());

    List<TextSpan> texts = new List<TextSpan>();
    if (index > 0) {
      texts.add(TextSpan(
        text: text.substring(0, index),
        style: normalStyle,
      ));
    }
    texts.add(TextSpan(
      text: text.substring(index, index + _searchKeyword.length),
      style: highlightStyle,
    ));
    if (index + _searchKeyword.length < text.length) {
      texts.add(TextSpan(
        text: text.substring(index + _searchKeyword.length),
        style: normalStyle,
      ));
    }

    return RichText(
      text: TextSpan(
        children: texts,
      ),
    );
  }
}
