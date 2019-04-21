import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:intl/intl.dart';

class StatusItem extends StatelessWidget {
  String name;
  DateTime timestamp;
  String thumbnailUrl;
  bool isSeen;
  var onTap;

  StatusItem({
    this.name,
    this.timestamp,
    this.thumbnailUrl,
    this.isSeen,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: _getThumbnail(),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        DateFormat('dd/MM/yy, HH:mm').format(timestamp),
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _getThumbnail() {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          border: new Border.all(
            color: isSeen ? Colors.grey : statusThumbnailBorderColor,
            width: 2.0,
          )
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            )
        ),
      ),
    );
  }
}
