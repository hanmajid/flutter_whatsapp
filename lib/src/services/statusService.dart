import 'package:flutter_whatsapp/src/models/statusList.dart';
import 'package:http/http.dart' as http;

String url = 'https://hanmajid.com/api/statuses';

Future<StatusList> getStatuses() async {
  final response = await http.get('$url');
  return statusListFromJson(response.body);
}