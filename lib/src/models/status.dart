import 'dart:convert';

Status statusFromJson(String str) {
  final jsonData = json.decode(str);
  return Status.fromJson(jsonData);
}

class Status {
  int id;
  String name;
  DateTime timestamp;
  bool isSeen;
  String thumbnailUrl;
  List<String> imagesUrl;

  Status({
    this.id,
    this.name,
    this.timestamp,
    this.isSeen,
    this.thumbnailUrl,
    this.imagesUrl,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return new Status(
      id: json["id"],
      name: json["name"],
      timestamp: DateTime.parse(json["timestamp"]),
      isSeen: json["isSeen"],
      thumbnailUrl: json["thumbnailPath"],
    );
  }
}