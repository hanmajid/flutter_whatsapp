import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class ContactItem extends StatelessWidget {
  Contact _contact;
  String _searchKeyword;
  var _onProfileTap;
  var _onTap;

  ContactItem(
      this._contact, this._searchKeyword, this._onProfileTap, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      leading: SizedBox(
        width: 45.0,
        height: 45.0,
        child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.account_circle,
              size: 45.0,
            ),
            color: lightGrey,
            onPressed: _onProfileTap
        ),
      ),
      title: _searchKeyword == null || _searchKeyword.isEmpty
          ? Text(
              _contact.displayName,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : _getHighlightedName(
              _contact.displayName,
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
//      subtitle: Text(
//        _contact.displayName.lastMessage.content,
//        maxLines: 1,
//      ),
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
