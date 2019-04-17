import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/models/chat.dart';
import 'package:flutter_whatsapp/models/message.dart';
import 'package:flutter_whatsapp/screens/cameraScreen.dart';
import 'package:flutter_whatsapp/screens/chatDetailScreen.dart';
import 'package:flutter_whatsapp/src/app.dart';

void main() {
  runApp(FlutteredApp());
}

//Future<void> main() async {
//  // Fetch the available cameras before initializing the app.
//  try {
//    cameras = await availableCameras();
//  } on CameraException catch (e) {
//    logError(e.code, e.description);
//  }
//  runApp(MainApp());
//}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainHome();
  }
}

class MainHome extends StatefulWidget {
  const MainHome({Key key}) : super(key: key);

  @override
  _MainHomeState createState() {
    return _MainHomeState();
  }
}

class _MainHomeState extends State<MainHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex;
  final List<FloatingActionButton> _fabs = [
    null,
    new FloatingActionButton(
        child: Icon(Icons.message),
        backgroundColor: new Color(0xff20c659),
        foregroundColor: Colors.white,
        onPressed: () {}),
    new FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: new Color(0xff20c659),
        foregroundColor: Colors.white,
        onPressed: () {}),
    new FloatingActionButton(
        child: Icon(Icons.add_call),
        backgroundColor: new Color(0xff20c659),
        foregroundColor: Colors.white,
        onPressed: () {}),
  ];

  ScrollController _scrollViewController;

  bool _selectMode = false;

  @override
  void initState() {
    super.initState();
    _tabIndex = 1;
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    _scrollViewController = new ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xff075e54);
    final primaryColorSelectMode = const Color(0xff00897b);
    final ThemeData themeData = new ThemeData(
      primaryColor: primaryColor,
      accentColor: Colors.white,
      selectedRowColor: Colors.blue,
    );
    final ThemeData themeDataSelectMode = new ThemeData(
      primaryColor: primaryColorSelectMode,
      accentColor: Colors.white,
      selectedRowColor: Colors.blue,
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp Flutter',
        theme: _selectMode ? themeDataSelectMode : themeData,
        home: Scaffold(
          body: new NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return _selectMode
                    ? _getSelectAppBar(
                        context, innerBoxIsScrolled, _tabController)
                    : _getDefaultAppBar(
                        context, innerBoxIsScrolled, _tabController);
              },
              body: TabBarView(controller: _tabController, children: [
                CameraHome(),
                TabChats(_onChatLongPress),
                Icon(Icons.more),
                Icon(Icons.more),
              ])),
          floatingActionButton: _getFab(),
        ));
  }

  void _onChatLongPress() {
    setState(() {
      _selectMode = !_selectMode;
    });
  }

  Widget _getFab() {
    return _fabs[_tabIndex];
  }

  _getDefaultAppBar(BuildContext context, bool innerBoxIsScrolled,
      TabController tabController) {
    return <Widget>[
      new SliverAppBar(
        title: Text("WhatApp"),
        pinned: true,
        floating: true,
        snap: true,
        forceElevated: innerBoxIsScrolled,
        actions: <Widget>[
          IconButton(
            tooltip: "Search",
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "More options",
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            icon: Icon(Icons.camera_alt),
          ),
          Tab(
            text: "CHATS",
          ),
          Tab(
            text: "STATUS",
          ),
          Tab(
            text: "CALLS",
          ),
        ]),
      )
    ];
  }

  _getSelectAppBar(BuildContext context, bool innerBoxIsScrolled,
      TabController tabController) {
    return <Widget>[
      new SliverAppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        pinned: true,
        floating: true,
        snap: true,
        forceElevated: innerBoxIsScrolled,
        actions: <Widget>[
          IconButton(
            tooltip: "Pin chat",
            icon: const Icon(Icons.trending_up),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Delete chat",
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Mute notifications",
            icon: const Icon(Icons.volume_off),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Archive chats",
            icon: const Icon(Icons.archive),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "More options",
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            icon: Icon(Icons.camera_alt),
          ),
          Tab(
            text: "CHATS",
          ),
          Tab(
            text: "STATUS",
          ),
          Tab(
            text: "CALLS",
          ),
        ]),
      )
    ];
  }
}

class TabChats extends StatefulWidget {
  var onChatLongPress;

  TabChats(this.onChatLongPress);

  @override
  _TabChatsState createState() => _TabChatsState();
}

class _TabChatsState extends State<TabChats> {
  static List<Message> _messages = [
    new Message('Halo', new DateTime.now(), true),
    new Message('Hi', new DateTime.now(), false),
    new Message('How are you?', new DateTime.now(), false),
  ];
  final _chats = [
    new Chat('Andi', _messages, '16/04/19'),
    new Chat('Budi', _messages, '16/04/19'),
    new Chat('Andi', _messages, '16/04/19'),
  ];
  List<Chat> _selectedChats;

  @override
  void initState() {
    super.initState();
    _selectedChats = new List<Chat>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, i) {
          return _buildChatItem(context, _chats[i]);
        });
  }

  Widget _buildChatItem(BuildContext context, Chat chat) {
    return Container(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        leading: CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(
                "https://api.adorable.io/avatars/285/abott@adorable.png")),
        title: Text(
          chat.name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          chat.lastMessage,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          chat.date,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(chat: chat)));
        },
        onLongPress: () {
//        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("On long press..")));
          widget.onChatLongPress();
          _selectedChats.add(chat);
        },
        selected: _selectedChats.contains(chat),
      ),
    );
  }
}
