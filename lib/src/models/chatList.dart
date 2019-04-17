import 'dart:convert';

import 'package:flutter_whatsapp/src/models/chat.dart';

ChatList chatListFromJson(String str) {
  final jsonData = json.decode(str);
  return ChatList.fromJson(jsonData);
}

class ChatList {
  List<Chat> chats;

  ChatList({
    this.chats
  });

  factory ChatList.fromJson(List<dynamic> json) {
    List<Chat> chats = new List<Chat>();
    chats = json.map((i) => Chat.fromJson(i)).toList();

    return new ChatList(
      chats: chats,
    );
  }
}
