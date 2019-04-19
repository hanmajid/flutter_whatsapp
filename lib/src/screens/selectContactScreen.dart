import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_whatsapp/src/helpers/dialogHelper.dart';
import 'package:flutter_whatsapp/src/widgets/contactItem.dart';

class SelectContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select contact'),
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
      body: SelectContact(),
    );
  }

  void _selectOption(dynamic option) {

  }
}

class SelectContact extends StatefulWidget {
  @override
  _SelectContact createState() => _SelectContact();
}

class _SelectContact extends State<SelectContact> {

  Future<Iterable<Contact>> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = _getContacts();
  }

  Future<Iterable<Contact>> _getContacts() async {
    return await ContactsService.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Contact>>(
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
                  return ContactItem(snapshot.data.elementAt(i),
                      null,
                      () => onTapProfileContactItem(snapshot.data.elementAt(i)), () {});
                });
        }
        return null; // unreachable
      },
    );
  }

  void onTapProfileContactItem(Contact contact) {
    Dialog profileDialog = getProfileDialog(
      imageUrl: null,
      name: contact.displayName,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => profileDialog
    );
  }

}