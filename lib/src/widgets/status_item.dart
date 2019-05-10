import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/text_helpers.dart';
import 'package:flutter_whatsapp/src/models/status.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:intl/intl.dart';

import 'dart:math';

class StatusItem extends StatelessWidget {
  final Status status;
  final String title;
  final String subtitle;
  final String thumbnail;
  final Function onTap;
  final String searchKeyword;

  StatusItem({
    this.status,
    this.title,
    this.subtitle,
    this.thumbnail,
    this.onTap,
    this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: status != null
          ? _getThumbnail(status.isSeen, status.numImages)
          : Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 28.0,
            backgroundImage: CachedNetworkImageProvider(thumbnail),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: fabBgColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Icon(
                Icons.add,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      title: status != null
          ? TextHelpers.getHighlightedText(
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
              ))
          : Text(
          title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        status != null
            ? DateFormat('dd/MM/yy, HH:mm').format(status.timestamp)
            : subtitle,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _getThumbnail(bool isSeen, int statusNum) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: CustomPaint(
        painter: StatusBorderPainter(isSeen: isSeen, statusNum: statusNum),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: CachedNetworkImageProvider(status.thumbnailUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
              border: new Border.all(
                color: Colors.white,
                width: 2.0,
              )),
        ),
      ),
    );
  }
}

degreeToRad(double degree) {
  return degree * pi / 180;
}

class StatusBorderPainter extends CustomPainter {

  bool isSeen;
  int statusNum;

  StatusBorderPainter({this.isSeen, this.statusNum});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = isSeen ? Colors.grey : statusThumbnailBorderColor
      ..style = PaintingStyle.stroke;
    drawArc(canvas, paint, size, statusNum);
  }

  void drawArc(Canvas canvas, Paint paint, Size size, int count) {
    if(count == 1) {
      canvas.drawArc(
          new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToRad(0),
          degreeToRad(360),
          false,
          paint
      );
    }
    else {
      double degree = -90;
      double arc = 360 / count;
      for(int i = 0; i < count; i++) {
        canvas.drawArc(
            new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToRad(degree+4),
            degreeToRad(arc-8),
            false,
            paint
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
