import 'dart:async';

import 'package:flutter_whatsapp/src/models/call.dart';
import 'package:flutter_whatsapp/src/models/call_detail.dart';
import 'package:flutter_whatsapp/src/models/call_list.dart';
import 'package:http/http.dart' as http;

String url = 'https://hanmajid.com/api/calls';

class CallService {
  static Future<CallList> getCalls() async {
//    final response = await http.get('$url');
//    return callListFromJson(response.body);

    return Future.delayed(Duration(seconds: 2), () {
      return new CallList(
        calls: <Call>[
          new Call(
              id: 1,
              name: 'Fauzan',
              avatarUrl: 'https://api.adorable.io/avatars/285/abott@adorable.png',
              callDetails: <CallDetail>[
                new CallDetail(
                  isIncoming: true,
                  isMissed: true,
                  timestamp: DateTime.parse('2019-04-16T18:42:49.608466Z'),
                )
              ]
          ),
        ]
      );
    });
  }
}
