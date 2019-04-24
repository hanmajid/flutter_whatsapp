import 'dart:convert';

import 'package:flutter_whatsapp/src/models/status.dart';

StatusList statusListFromJson(String str) {
  final jsonData = json.decode(str);
  return StatusList.fromJson(jsonData);
}

class StatusList {
  List<Status> statuses;

  StatusList({
    this.statuses,
  });

  factory StatusList.fromJson(List<dynamic> json) {
    List<Status> statuses = new List<Status>();
    statuses = json.map<Status>((i) => Status.fromJson(i)).toList();

    return new StatusList(
      statuses: statuses,
    );
  }
}