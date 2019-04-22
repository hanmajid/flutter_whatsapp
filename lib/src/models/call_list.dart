
import 'dart:convert';

import 'package:flutter_whatsapp/src/models/call.dart';

CallList callListFromJson(String str) {
  var jsonData = json.decode(str);
  return CallList.fromJson(jsonData);
}

class CallList {
  List<Call> calls;

  CallList({
    this.calls,
  });

  factory CallList.fromJson(List<dynamic> json) {
    List<Call> calls = new List<Call>();
    calls = json.map<Call>((i) => Call.fromJson(i)).toList();

    return new CallList(
      calls: calls,
    );
  }
}