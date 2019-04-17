import 'package:flutter_whatsapp/models/message.dart';

class Chat {
  String name;
  String lastMessage;
  String date;
  List<Message> messages;

  Chat(this.name, this.messages, this.date) {
    this.lastMessage = this.messages[this.messages.length - 1].text;
  }
}