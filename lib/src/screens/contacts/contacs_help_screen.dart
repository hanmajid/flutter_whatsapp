import 'package:flutter/material.dart';

class ContactsHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _helpText = [
      'If some of your friends don\'t appear in the contacts list, we recommend the following steps:',
      'Make sure that your friend\'s phone number is in your address book',
      'Make sure that your friend is using WhatzApp Messenger',
    ];

    TextStyle _textStyle = const TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts help'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Text(
                  _helpText[0],
                style: _textStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _buildBulletPointText(_helpText[1], _textStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _buildBulletPointText(_helpText[2], _textStyle),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBulletPointText(String text, TextStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            '•',
          style: style,
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
              text,
            style: style,
          ),
        ),
      ],
    );
  }
}