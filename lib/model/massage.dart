class Message {
  String? toId;
  String? msg;
  String? read;
  String? fromId;
  String? sent;

  Message({
    this.toId,
    this.msg,
    this.read,
    this.fromId,
    this.sent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      toId: json['toId'],
      msg: json['msg'],
      read: json['read'],
      fromId: json['fromId'],
      sent: json['sent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'toId': toId,
      'msg': msg,
      'read': read,
      'fromId': fromId,
      'sent': sent,
    };
  }
}
