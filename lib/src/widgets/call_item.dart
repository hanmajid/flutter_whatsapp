import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/text_helpers.dart';
import 'package:flutter_whatsapp/src/models/call.dart';
import 'package:flutter_whatsapp/src/widgets/line_painter.dart';
import 'package:intl/intl.dart';

class CallItem extends StatelessWidget {
  final Call call;
  final String searchKeyword;
  final Function onProfileTap;
  final Function onTap;
  final Function onLeadingTap;

  CallItem({
    this.call,
    this.searchKeyword,
    this.onProfileTap,
    this.onTap,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            onProfileTap();
          },
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: CachedNetworkImageProvider(call.avatarUrl),
          ),
        ),
        title: searchKeyword == null || searchKeyword.isEmpty
            ? Text(
                call.name,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            : TextHelpers.getHighlightedText(
                call.name,
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
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            call.lastCall.isIncoming
                ? Icon(
                    Icons.call_received,
                    color: call.lastCall.isMissed ? Colors.red : Colors.green,
                    size: 16.0,
                  )
                : Icon(
                    Icons.call_made,
                    color: call.lastCall.isMissed ? Colors.red : Colors.green,
                    size: 16.0,
                  ),
            call.callDetails.length > 1
                ? Text(
                    '(${call.callDetails.length})',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  )
                : Container(),
            Text(
              DateFormat('dd/MM/yy, HH:mm').format(call.lastCall.timestamp),
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.call,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: onLeadingTap),
        onTap: onTap,
      ),
    );
  }
}
