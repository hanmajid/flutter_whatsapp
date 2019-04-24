import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/screens/select_contact_screen.dart';
import 'package:flutter_whatsapp/src/tabs/calls_tab.dart';
import 'package:flutter_whatsapp/src/tabs/chats_tab.dart';
import 'package:flutter_whatsapp/src/tabs/status_tab.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {

  List<Widget> _actionButtons;
  List<List<PopupMenuItem>> _popupMenus;

  int _tabIndex;
  TabController _tabController;
  List<Widget> _tabBars;
  List<Widget> _tabViews;
  ChatsTab _chatsTab;
  StatusTab _statusTab;
  CallsTab _callsTab;

  bool _isSearching;
  TextField _searchBar;
  TextEditingController _searchBarController;

  List<Widget> _fabs;

  static final TextStyle _textBold = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _tabIndex = 1; // Start at second tab.
    _isSearching = false;

    _searchBarController = new TextEditingController();

    _searchBar  = new TextField(
      controller: _searchBarController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
    );
    _chatsTab = ChatsTab(_searchBarController);
    _statusTab = StatusTab(_searchBarController);
    _callsTab = CallsTab(_searchBarController);
    _tabController = new TabController(
      length: 4,
      initialIndex: _tabIndex,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
        _isSearching = false;
        _searchBarController?.text = "";
      });
    });

    _actionButtons = <Widget>[
      IconButton(
        tooltip: "Search",
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearching = true;
            _searchBarController?.text = "";
          });
        },
      ),
      PopupMenuButton(
        tooltip: "More options",
        onSelected: _selectOption,
        itemBuilder: (BuildContext context) {
          return _popupMenus[_tabIndex];
        },
      ),
    ];

    _tabBars = <Widget>[
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

    _tabViews = <Widget>[
      Container(
        color: Colors.black,
        child: Center(
          child: Text('Camera'),
        ),
      ),
      _chatsTab,
      _statusTab,
      _callsTab,
    ];

    _popupMenus  = [
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

    _fabs  = [
      null,
      new FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: fabBgColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return SelectContactScreen();
                }
            ));
          }),
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabIndex == 0
          ? null
        : AppBar(
        backgroundColor: _isSearching
          ? Colors.white
          : null,
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                color: const Color(0xff075e54),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchBarController?.text = "";
                  });
                },
              )
            : null,
        title: _isSearching
            ? _searchBar
            : Text(
                'WhatsApp',
                style: _textBold,
              ),
        actions: _isSearching
            ? null
            : _actionButtons,
        bottom: _isSearching
          ? null
          : TabBar(
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

  void _getPopupMenu(BuildContext context) {
    return;
  }

  void _selectOption(dynamic option) {}
}
