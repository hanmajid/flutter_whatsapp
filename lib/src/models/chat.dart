import 'dart:convert';

class Message {
  String content;
  DateTime timestamp;
  bool isYou;
  bool isRead;
  bool isSent;

  Message({
    this.content,
    this.timestamp,
    this.isYou,
    this.isRead,
    this.isSent
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return new Message(
      content: json["content"],
      timestamp: DateTime.parse(json["timestamp"]),
      isYou: json["isYou"],
      isRead: json["isRead"],
      isSent: true,
    );
  }
}

Chat chatFromJson(String str) {
  final jsonData = json.decode(str);
  return Chat.fromJson(jsonData);
}

Chat chatFromJsonFull(String str) {
  final jsonData = json.decode(str);
  return Chat.fromJsonFull(jsonData);
}

class Chat {
  int id;
  String name;
  String avatarUrl;
  Message lastMessage;
  List<Message> messages;
  int unreadMessages;

  Chat({
    this.id,
    this.name,
    this.avatarUrl,
    this.lastMessage,
    this.messages,
    this.unreadMessages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return new Chat(
      id: json["id"],
      name: json["name"],
      avatarUrl: json["avatarPath"],
      lastMessage: Message.fromJson(json["lastMessage"]),
      unreadMessages: json["unreadMessages"],
    );
  }

  factory Chat.fromJsonFull(Map<String, dynamic> json) {
    List<Message> messages = new List<Message>();
    messages = json["messages"].map<Message>((i) => Message.fromJson(i)).toList();

    return new Chat(
      id: json["id"],
      name: json["name"],
      avatarUrl: json["avatarPath"],
      messages: messages,
      unreadMessages: json["unreadMessages"],
    );
  }
}
