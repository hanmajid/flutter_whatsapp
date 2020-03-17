import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/screens/settings/help/android_intent_helpers.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:flutter_whatsapp/src/widgets/contact_item.dart';

enum NewChatOptions {
  inviteAFriend,
  contacts,
  refresh,
  help,
}

class NewChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectContact();
  }
}

class SelectContact extends StatefulWidget {
  @override
  _SelectContact createState() => _SelectContact();
}

class _SelectContact extends State<SelectContact> {

  Future<Iterable<Contact>> _contacts;
  var numContacts;

  Future<int> _getNumContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return contacts.length;
  }

  @override
  void initState() {
    super.initState();
    _contacts = _getContacts();
    _getNumContacts().then((num) {
      setState(() {
        numContacts = num;
      });
    });
  }

  Future<Iterable<Contact>> _getContacts() async {
    return await ContactsService.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                  'Select contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: numContacts == null
               ? null
              : Text(
                  '$numContacts contacts',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<NewChatOptions>(
            tooltip: "More options",
            onSelected: _onSelectOption,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<NewChatOptions>(
                  child: Text("Invite a friend"),
                  value: NewChatOptions.inviteAFriend,
                ),
                PopupMenuItem<NewChatOptions>(
                  child: Text("Contacts"),
                  value: NewChatOptions.contacts,
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: NewChatOptions.refresh,
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: NewChatOptions.help,
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<Iterable<Contact>>(
        future: _contacts,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              );
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              List<dynamic> data = List<dynamic>();
              data.add(ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: fabBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.group,
                    size: 32.0,
                    color: Colors.white,
                  ),
                ),
                title: Text('New group',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                onTap: (){
                  Application.router.navigateTo(
                    context,
                    //Routes.newChatGroup,
                    Routes.futureTodo,
                    transition: TransitionType.inFromRight,
                  );
                },
              ));
              data.add(ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: fabBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person_add,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                title: Text('New contact',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                onTap: (){
                  AndroidIntentHelpers.createContact(context);
                },
              ));
              data.addAll(snapshot.data);
              data.add(ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.share),
                ),
                title: Text('Invite friends',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () {
                  AndroidIntentHelpers.inviteFriend(context);
                },
              ));
              data.add(ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.help),
                ),
                title: Text('Contacts help',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                onTap: (){
                  Application.router.navigateTo(
                    context,
                    Routes.contactsHelp,
                    transition: TransitionType.inFromRight,
                  );
                },
              ));
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    if(i < 2 || i > data.length-3) {
                      return data[i];
                    }
                    return ContactItem(
                        contact: data.elementAt(i),
                        onProfileTap: () => onTapProfileContactItem(context, snapshot.data.elementAt(i)),
                        onTap:() {
                        }
                        );
                  });
          }
          return null; // unreachable
        },
      ),
    );
  }

  void onTapProfileContactItem(BuildContext context, Contact contact) {
    Dialog profileDialog = DialogHelpers.getProfileDialog(
      context: context,
      id: 1,
      imageUrl: null,
      name: contact.displayName,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => profileDialog
    );
  }


  void _onSelectOption(NewChatOptions option) {
    switch(option) {
      case NewChatOptions.inviteAFriend:
        AndroidIntentHelpers.inviteFriend(context);
        break;
      case NewChatOptions.contacts:
        AndroidIntentHelpers.openContactApp(context);
        break;
      case NewChatOptions.refresh:
        break;
      case NewChatOptions.help:
        Application.router.navigateTo(
          context,
          Routes.contactsHelp,
          transition: TransitionType.inFromRight,
        );
        break;
    }
  }
}