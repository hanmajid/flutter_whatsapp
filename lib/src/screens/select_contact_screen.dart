import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/widgets/contact_item.dart';

class SelectContactScreen extends StatelessWidget {
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
                  '${numContacts} contacts',
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
          PopupMenuButton(
            tooltip: "More options",
            onSelected: _selectOption,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ContactItem(
                        contact: snapshot.data.elementAt(i),
                        onProfileTap: () => onTapProfileContactItem(snapshot.data.elementAt(i)),
                        onTap:() {}
                        );
                  });
          }
          return null; // unreachable
        },
      ),
    );
  }

  void onTapProfileContactItem(Contact contact) {
    Dialog profileDialog = DialogHelpers.getProfileDialog(
      imageUrl: null,
      name: contact.displayName,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => profileDialog
    );
  }


  void _selectOption(dynamic option) {

  }
}