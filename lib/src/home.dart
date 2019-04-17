import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/tabs/chatsTab.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  static int _tabIndex;
  TabController _tabController;

  List<Widget> _actionButtons = <Widget>[
    IconButton(
      tooltip: "Search",
      icon: const Icon(Icons.search),
      onPressed: () {},
    ),
    PopupMenuButton(
      tooltip: "More options",
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return _popupMenus[_tabIndex];
      },
    ),
  ];

  static List<List<PopupMenuItem>> _popupMenus = [
    null,
    [
      PopupMenuItem(
        child: Text("New group"),
        value: "New group",
      ),
      PopupMenuItem(
        child: Text("New broadcast"),
        value: "New broadcast",
      ),
      PopupMenuItem(
        child: Text("WhatsApp Web"),
        value: "WhatsApp Web",
      ),
      PopupMenuItem(
        child: Text("Starred messages"),
        value: "Starred messages",
      ),
      PopupMenuItem(
        child: Text("Settings"),
        value: "Settings",
      ),
    ],
    [
      PopupMenuItem(
        child: Text("Status privacy"),
        value: "Status privacy",
      ),
      PopupMenuItem(
        child: Text("Settings"),
        value: "Settings",
      ),
    ],
    [
      PopupMenuItem(
        child: Text("Clear call log"),
        value: "Clear call log",
      ),
      PopupMenuItem(
        child: Text("Settings"),
        value: "Settings",
      ),
    ],
  ];

  static _getPopupMenu(BuildContext context) {
    return ;
  }
//
  static void _select(dynamic item) {

  }

  static final TextStyle _textBold = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  List<Widget> _tabBars = <Widget>[
    Tab(
      icon: Icon(Icons.camera_alt),
    ),
    Tab(
      child: Text(
        "CHATS",
        style: _textBold,
      ),
    ),
    Tab(
      child: Text(
        "STATUS",
        style: _textBold,
      ),
    ),
    Tab(
      child: Text(
        "CALLS",
        style: _textBold,
      ),
    ),
  ];

  // TODO: Change this to actual TabView.
  List<Widget> _tabViews = <Widget>[
    Center(
      child: Text('Camera'),
    ),
    ChatsTab(),
    Center(
      child: Text('Status'),
    ),
    Center(
      child: Text('Calls'),
    ),
  ];

  /// FloatingActionButton's background color
  static final fabBgColor = const Color(0xff20c659);
  static final fabBgSecondaryColor = const Color(0xff507578);

  List<Widget> _fabs = [
    null,
    new FloatingActionButton(
        child: Icon(Icons.message),
        backgroundColor: fabBgColor,
        foregroundColor: Colors.white,
        onPressed: () {}),
    Container(
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new FloatingActionButton(
              mini: true,
              child: Icon(Icons.edit),
              backgroundColor: Colors.white,
              foregroundColor: fabBgSecondaryColor,
              onPressed: () {}),
          new SizedBox(
            height: 16.0,
          ),
          new FloatingActionButton(
              child: Icon(Icons.camera_alt),
              backgroundColor: fabBgColor,
              foregroundColor: Colors.white,
              onPressed: () {}),
        ],
      ),
    ),
    new FloatingActionButton(
        child: Icon(Icons.add_call),
        backgroundColor: fabBgColor,
        foregroundColor: Colors.white,
        onPressed: () {}),
  ];

  @override
  void initState() {
    super.initState();
    _tabIndex = 1; // Start at second tab.
    _tabController = new TabController(
      length: 4,
      initialIndex: _tabIndex,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: _textBold,
        ),
        actions: _actionButtons,
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabBars,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
      floatingActionButton: _fabs[_tabIndex],
    );
  }
}
