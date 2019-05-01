import 'package:flutter/material.dart';

enum StarredMessageOptions {
  unstarAll,
}

class StarredMessagesScreen extends StatefulWidget {
  @override
  _StarredMessagesScreenState createState() => _StarredMessagesScreenState();
}

class _StarredMessagesScreenState extends State<StarredMessagesScreen> {

  List<String> messages;

  @override
  void initState() {
    super.initState();

    messages = new List<String>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starred messages'),
        actions: messages.length <= 0
            ? []
            : <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
          PopupMenuButton<StarredMessageOptions>(
            tooltip: "More options",
            onSelected: _selectOption,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<StarredMessageOptions>(
                  child: Text('Unstar all'),
                  value: StarredMessageOptions.unstarAll,
                ),
              ];
            },
          )
        ],
      ),
      body: messages.length <= 0
          ? _buildEmptyPage()
          : Center(
        child: Text('TODO'),
      ),
    );
  }

  _buildEmptyPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75.0),
            color: Color(0xff1dbea5),
          ),
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: 75.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80.0, left: 80.0, top: 32.0),
          child: Text(
            'Tap and hold on any message in any chat to star it, so you can easily find it later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.2,
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }

  _selectOption(StarredMessageOptions option) {
    switch(option) {
      case StarredMessageOptions.unstarAll:
        break;
    }
  }
}