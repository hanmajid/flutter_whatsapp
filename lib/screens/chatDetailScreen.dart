import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/models/chat.dart';

class ChatDetailScreen extends StatelessWidget {
  final Chat chat;

  const ChatDetailScreen({Key key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset('assets/images/accounts/account_1.jpg'),
              ),
            ),
            Text(chat.name),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Video call",
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Voice call",
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "More options",
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.brown[50],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Text(chat.lastMessage),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message'
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
