// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String? toId;
  String? msg;
  String? readn;
  String? fromId;
  String? sent;

  Message({
    this.toId,
    this.msg,
    this.readn,
    this.fromId,
    this.sent,
  });

  factory Message.fromJson(json) {
    return Message(
      toId: json['toId'],
      msg: json['msg'],
      readn: json['readn']!=''?json['readn']:null,
      fromId: json['fromId'],
      sent: json['sent'],
    );
  }

  toJson() {
    return "'$toId','$msg','$readn','$fromId','$sent'";
  }

  @override
  String toString() {
    return 'Message(toId: $toId, msg: $msg, readn: $readn, fromId: $fromId, sent: $sent)';
  }
}
