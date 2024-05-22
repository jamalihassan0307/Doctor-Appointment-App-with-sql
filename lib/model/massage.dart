// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String? toId;
  String? msg;
  String? readS;
  String? fromId;
  String? sent;

  Message({
    this.toId,
    this.msg,
    this.readS,
    this.fromId,
    this.sent,
  });

  factory Message.fromJson(json) {
    return Message(
      toId: json['toId'],
      msg: json['msg'],
      readS: json['readS'],
      fromId: json['fromId'],
      sent: json['sent'],
    );
  }

  toJson() {
    return "'$toId','$msg','$readS','$fromId','$sent'";
  }

  @override
  String toString() {
    return 'Message(toId: $toId, msg: $msg, readS: $readS, fromId: $fromId, sent: $sent)';
  }
}
