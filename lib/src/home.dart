import 'package:async/async.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_whatsapp/src/screens/camera_screen.dart';
import 'package:flutter_whatsapp/src/services/chat_service.dart';
import 'package:flutter_whatsapp/src/services/status_service.dart';
import 'package:flutter_whatsapp/src/tabs/calls_tab.dart';
import 'package:flutter_whatsapp/src/tabs/chats_tab.dart';
import 'package:flutter_whatsapp/src/tabs/status_tab.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

enum HomeOptions {
  settings,
  // Chats Tab
  newGroup,
  newBroadcast,
  whatsappWeb,
  starredMessages,
  // Status Tab
  statusPrivacy,
  // Calls Tab
  clearCallLog,
  readMe,
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> _actionButtons;
  List<List<PopupMenuItem<HomeOptions>>> _popupMenus;

  int _tabIndex;
  TabController _tabController;

  bool _isSearching;
  TextField _searchBar;
  TextEditingController _searchBarController;

  List<Widget> _fabs;

  static final TextStyle _textBold = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  String _searchKeyword = '';

  AsyncMemoizer _memoizerChats = AsyncMemoizer();
  Future<dynamic> _chatList;
  AsyncMemoizer _memoizerStatus = AsyncMemoizer();
  Future<dynamic> _statusList;
  AsyncMemoizer _memoizerCalls = AsyncMemoizer();

  // int _unreadMessages = 0;
  AnimationController unreadChatsBadgeAnimationController;
  Animation unreadChatsBadgeAnimation;

  Future<dynamic> _getChatList() {
    return _memoizerChats.runOnce(() {
      return ChatService.getChats().then((chatlist) {
        updateAppBadge(chatlist.unreadMessages);
        return chatlist;
      });
    });
  }

  bool isNewStatus = false;

  Future<dynamic> _getStatusList() {
    return _memoizerStatus.runOnce(() async {
      return StatusService.getStatuses().whenComplete(() {
        setState(() {
          isNewStatus = true;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _chatList = _getChatList();
    _statusList = _getStatusList();
    _tabIndex = 1; // Start at second tab.
    _isSearching = false;

    unreadChatsBadgeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1),
    );
    unreadChatsBadgeAnimation = Tween(
      begin: 1.0,
      end: 0.7,
    ).animate(unreadChatsBadgeAnimationController);

    _searchBarController = new TextEditingController();
    _searchBarController.addListener(() {
      setState(() {
        _searchKeyword = _searchBarController.text;
      });
    });

    _searchBar = new TextField(
      controller: _searchBarController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
    );
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
        if (_tabController.index == 2) {
          isNewStatus = false;
        }

        if (_tabController.index != 1) {
          unreadChatsBadgeAnimationController.forward();
        } else {
          unreadChatsBadgeAnimationController.reverse();
        }
      });
    });

    _actionButtons = <Widget>[
      IconButton(
        tooltip: "Search",
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _searhBarOpen = true;
            _isSearching = true;
            _searchBarController?.text = "";
          });
        },
      ),
      PopupMenuButton<HomeOptions>(
        tooltip: "More options",
        onSelected: _selectOption,
        itemBuilder: (BuildContext context) {
          return _popupMenus[_tabIndex];
        },
      ),
    ];

    _popupMenus = [
      null,
      [
        PopupMenuItem<HomeOptions>(
          child: Text("New group"),
          value: HomeOptions.newGroup,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("New broadcast"),
          value: HomeOptions.newBroadcast,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("WhatzApp Web"),
          value: HomeOptions.whatsappWeb,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("Starred messages"),
          value: HomeOptions.starredMessages,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("Settings"),
          value: HomeOptions.settings,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("README", style: TextStyle(color: Colors.red)),
          value: HomeOptions.readMe,
        ),
      ],
      [
        PopupMenuItem<HomeOptions>(
          child: Text("Status privacy"),
          value: HomeOptions.statusPrivacy,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("Settings"),
          value: HomeOptions.settings,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("README", style: TextStyle(color: Colors.red)),
          value: HomeOptions.readMe,
        ),
      ],
      [
        PopupMenuItem<HomeOptions>(
          child: Text("Clear call log"),
          value: HomeOptions.clearCallLog,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("Settings"),
          value: HomeOptions.settings,
        ),
        PopupMenuItem<HomeOptions>(
          child: Text("README", style: TextStyle(color: Colors.red)),
          value: HomeOptions.readMe,
        ),
      ],
    ];

    _fabs = [
      null,
      new FloatingActionButton(
          child: Icon(Icons.message),
          backgroundColor: fabBgColor,
          foregroundColor: Colors.white,
          onPressed: () async {
            if (await allPermissionsGranted()) {
              goToNewChatScreen();
            } else {
              requestPermission();
            }
          }),
      Container(
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new FloatingActionButton(
                heroTag: 'newTextStatus',
                mini: true,
                child: Icon(Icons.edit),
                backgroundColor: Colors.white,
                foregroundColor: fabBgSecondaryColor,
                onPressed: () {
                  Application.router.navigateTo(
                    context,
                    Routes.newTextStatus,
                    transition: TransitionType.inFromRight,
                  );
                }),
            new SizedBox(
              height: 16.0,
            ),
            new FloatingActionButton(
                heroTag: 'newStatus',
                child: Icon(Icons.camera_alt),
                backgroundColor: fabBgColor,
                foregroundColor: Colors.white,
                onPressed: () {
                  Application.router.navigateTo(
                    context,
                    Routes.newStatus,
                    transition: TransitionType.inFromRight,
                  );
                }),
          ],
        ),
      ),
      new FloatingActionButton(
          child: Icon(Icons.add_call),
          backgroundColor: fabBgColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Application.router.navigateTo(
              context,
              Routes.newCall,
              transition: TransitionType.inFromRight,
            );
          }),
    ];
  }

  void goToNewChatScreen() {
    Application.router.navigateTo(
      context,
      "/chat/new",
      transition: TransitionType.inFromRight,
    );
  }

  @override
  void dispose() {
    unreadChatsBadgeAnimationController.dispose();
    _tabController.dispose();
    _searchBarController.dispose();
    super.dispose();
  }

  updateAppBadge(int count) async {
    bool appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      appBadgeSupported = res;
    } on PlatformException {
      appBadgeSupported = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (appBadgeSupported) {
      FlutterAppBadger.updateBadgeCount(count);
    }
  }

  bool _searhBarOpen = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_searhBarOpen) {
          setState(() {
            _searhBarOpen = false;
            _isSearching = false;
            _searchBarController?.text = "";
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _tabIndex == 0
            ? null
            : AppBar(
                backgroundColor: _isSearching ? Colors.white : null,
                leading: _isSearching
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: const Color(0xff075e54),
                        onPressed: () {
                          setState(() {
                            _searhBarOpen = false;
                            _isSearching = false;
                            _searchBarController?.text = "";
                          });
                        },
                      )
                    : null,
                title: _isSearching
                    ? _searchBar
                    : Text(
                        'WhatzApp',
                        style: _textBold,
                      ),
                actions: _isSearching ? null : _actionButtons,
                bottom: _isSearching
                    ? null
                    : TabBar(
                        controller: _tabController,
                        tabs: <Widget>[
                          Tab(
                            icon: Icon(Icons.camera_alt),
                          ),
                          Tab(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "CHATS",
                                    style: _textBold,
                                  ),
                                  FutureBuilder(
                                    future: _chatList,
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null)
                                        return Container();
                                      if (snapshot.data.unreadMessages <= 0)
                                        return Container();

                                      return FadeTransition(
                                        opacity: unreadChatsBadgeAnimation,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 4.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0))),
                                          alignment: Alignment.center,
                                          height: 18.0,
                                          width: 18.0,
                                          child: Text(
                                            '${snapshot.data.unreadMessages}',
                                            style: TextStyle(
                                              fontSize: 9.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "STATUS",
                                    style: _textBold,
                                  ),
                                  FutureBuilder(
                                    future: _statusList,
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null)
                                        return Container();
                                      if (!isNewStatus) return Container();

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          '•',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "CALLS",
                              style: _textBold,
                            ),
                          ),
                        ],
                        labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
              ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CameraScreen(),
            ChatsTab(
                searchKeyword: _searchKeyword,
                chatList: _chatList,
                refresh: () {
                  setState(() {
                    _memoizerChats = new AsyncMemoizer();
                    _chatList = _getChatList();
                  });
                }),
            StatusTab(
                searchKeyword: _searchKeyword,
                statusList: _statusList,
                refresh: () {
                  setState(() {
                    _memoizerStatus = new AsyncMemoizer();
                    _statusList = _getStatusList();
                  });
                }),
            CallsTab(
                searchKeyword: _searchKeyword,
                memoizer: _memoizerCalls,
                refresh: () {
                  setState(() {
                    _memoizerCalls = new AsyncMemoizer();
                  });
                }),
          ],
        ),
        floatingActionButton: _fabs[_tabIndex],
      ),
    );
  }

  void _selectOption(HomeOptions option) {
    switch (option) {
      case HomeOptions.newGroup:
        Application.router.navigateTo(
          context,
          //Routes.newChatGroup,
          Routes.futureTodo,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.newBroadcast:
        Application.router.navigateTo(
          context,
          //Routes.newChatBroadcast,
          Routes.futureTodo,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.whatsappWeb:
        Application.router.navigateTo(
          context,
          Routes.whatsappWeb,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.starredMessages:
        Application.router.navigateTo(
          context,
          Routes.starredMessages,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.settings:
        Application.router.navigateTo(
          context,
          Routes.settings,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.statusPrivacy:
        Application.router.navigateTo(
          context,
          //Routes.statusPrivacy,
          Routes.futureTodo,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.clearCallLog:
        Application.router.navigateTo(
          context,
          Routes.clearCallLog,
          transition: TransitionType.inFromRight,
        );
        break;
      case HomeOptions.readMe:
        Application.router.navigateTo(
          context,
          Routes.futureTodo,
          transition: TransitionType.inFromRight,
        );
        break;
    }
  }

  Future<bool> allPermissionsGranted() async {
    bool res = await Permission.contacts.isGranted;
    return res;
  }

  void requestPermission() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      goToNewChatScreen();
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Permission not granted'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
