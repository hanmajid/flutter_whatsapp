import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/textHelper.dart';
import 'package:flutter_whatsapp/src/models/status.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:intl/intl.dart';

class StatusItem extends StatelessWidget {
  Status status;
  var onTap;
  String searchKeyword;

  StatusItem({
    this.status,
    this.onTap,
    this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: _getThumbnail(),
      title: TextHelpers.getHighlightedText(
          status.name,
          searchKeyword,
          TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          )),
      subtitle: Text(
        DateFormat('dd/MM/yy, HH:mm').format(status.timestamp),
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
            color: status.isSeen ? Colors.grey : statusThumbnailBorderColor,
            width: 2.0,
          )
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(status.thumbnailUrl),
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
