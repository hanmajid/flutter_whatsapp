import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:flutter_whatsapp/src/models/chatList.dart';
import 'package:http/http.dart' as http;

String url = 'https://hanmajid.com/api/chats';

Future<ChatList> getChats() async {
  final response = await http.get('$url');
  return chatListFromJson(response.body);
}

Future<Chat> getChat(int id) async {
  final response = await http.get('$url/$id');
  return chatFromJsonFull(response.body);
}