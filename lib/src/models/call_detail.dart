class CallDetail {
  bool isIncoming;
  bool isMissed;
  DateTime timestamp;

  CallDetail({
    this.isIncoming,
    this.isMissed,
    this.timestamp,
  });

  factory CallDetail.fromJson(Map<String, dynamic> json) {
    return new CallDetail(
      isIncoming: json['isIncoming'],
      isMissed: json['isMissed'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}