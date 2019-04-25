import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class DialogHelpers {
  static Dialog getProfileDialog({
    @required BuildContext context,
    String imageUrl,
    String name,
    GestureTapCallback onTapMessage,
    GestureTapCallback onTapCall,
    GestureTapCallback onTapVideoCall,
    GestureTapCallback onTapInfo,
  }) {
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
      image: CachedNetworkImageProvider(imageUrl),
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
                    onPressed: onTapMessage ?? () => _defOnTapMessage(context),
                    color: secondaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: onTapCall ?? () => _defOnTapCall(context),
                    color: secondaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    onPressed: onTapVideoCall ?? () => _defOnTapVideoCall(context),
                    color: secondaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: onTapInfo ?? () => _defOnTapInfo(context),
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

  static _defOnTapMessage(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text('Message Button tapped'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static _defOnTapCall(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text('Call Button tapped'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static _defOnTapVideoCall(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text('Video Call Button tapped'),
          duration: Duration(seconds: 1),
      ),
    );
  }

  static _defOnTapInfo(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Info Button tapped'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}