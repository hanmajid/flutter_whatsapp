import 'dart:async';

import 'package:flutter_whatsapp/src/models/call_list.dart';
import 'package:http/http.dart' as http;

String url = 'https://hanmajid.com/api/calls';

class CallService {
  static Future<CallList> getCalls() async {
    final response = await http.get('$url');
    return callListFromJson(response.body);
  }
}
