import 'package:flutter_whatsapp/src/models/call_detail.dart';

class Call {
  int id;
  String name;
  String avatarUrl;
  List<CallDetail> callDetails;

  get lastCall => callDetails[callDetails.length-1];

  Call({
    this.id,
    this.name,
    this.avatarUrl,
    this.callDetails,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    List<CallDetail> callDetails = new List<CallDetail>();
    callDetails = json['calls'].map<CallDetail>((i) => CallDetail.fromJson(i)).toList();

    return Call(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarPath'],
      callDetails: callDetails,
    );
  }
}