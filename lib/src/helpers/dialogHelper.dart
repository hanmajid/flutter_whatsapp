import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

Dialog getProfileDialog({String imageUrl, String name}) {
  Widget image = imageUrl == null
      ? SizedBox(
          child: Container(
            decoration: BoxDecoration(
              color: profileDialogBgColor,
            ),
            height: 250.0,
            child: Center(
              child: Icon(Icons.account_circle, color: profileDialogIconColor, size: 120.0,),
            ),
          )
      )
      : Image(
          image: NetworkImage(imageUrl),
        );
  return new Dialog(
    shape: RoundedRectangleBorder(),
    child: Container(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              child: Stack(
                children: <Widget>[
                  image,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {},
                  color: secondaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                  color: secondaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {},
                  color: secondaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {},
                  color: secondaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
