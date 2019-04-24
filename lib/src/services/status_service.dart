import 'dart:async';

import 'package:flutter_whatsapp/src/models/status_list.dart';
import 'package:http/http.dart' as http;

String url = 'https://hanmajid.com/api/statuses';

class StatusService {
  static Future<StatusList> getStatuses() async {
    final response = await http.get('$url');
    return statusListFromJson(response.body);
  }
}