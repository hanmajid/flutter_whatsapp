import 'dart:convert';

Status statusFromJson(String str) {
  final jsonData = json.decode(str);
  return Status.fromJson(jsonData);
}

Status statusFromJsonFull(String str) {
  final jsonData = json.decode(str);
  return Status.fromJsonFull(jsonData);
}

class Status {
  int id;
  String name;
  DateTime timestamp;
  bool isSeen;
  String thumbnailUrl;
  int numImages;
  List<String> imagesUrl;

  Status({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.isSeen,
    required this.thumbnailUrl,
    required this.numImages,
    this.imagesUrl = const [],
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return new Status(
      id: json["id"],
      name: json["name"],
      timestamp: DateTime.parse(json["timestamp"]),
      isSeen: json["isSeen"],
      numImages: json["numImages"],
      thumbnailUrl: json["thumbnailPath"],
    );
  }

  factory Status.fromJsonFull(Map<String, dynamic> jsonData) {
    List<String> imagesUrl = [];
    for (dynamic img in jsonData["images"]) {
      imagesUrl.add(img["path"]);
    }

    return new Status(
      id: jsonData["id"],
      name: jsonData["name"],
      timestamp: DateTime.parse(jsonData["timestamp"]),
      isSeen: jsonData["isSeen"],
      thumbnailUrl: jsonData["thumbnailPath"],
      numImages: jsonData["numImages"],
      imagesUrl: imagesUrl,
    );
  }
}
