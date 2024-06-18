// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:doctor_appointment_app/controller/chatController.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/m_date_util.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    Key? key,
    required this.message,
    required this.chatID,
    required this.current,
  }) : super(key: key);

  final Message message;
  final String chatID;
  final String current;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    bool isMe = widget.current == widget.message.fromId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _greenMessage() : _blueMessage());
  }

  Widget _blueMessage() {
    if (widget.message.readn == "") {
      ChatController.my.updateMessageReadStatus(widget.message, widget.chatID);
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: 80),
        child: ClipPath(
          clipper: UpperNipMessageClipper(MessageType.receive),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFE1E1E2),
            ),
            child: Text(
              widget.message.msg!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _greenMessage() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 80, top: 20),
        child: ClipPath(
          clipper: LowerNipMessageClipper(MessageType.send),
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
            decoration: BoxDecoration(
              color: Color(0xFF7165D6),
            ),
            child: Text(
              widget.message.msg!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: height * .015, horizontal: width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              OptionItem(
                  icon: Icon(Icons.copy_all_rounded,
                      color: Colors.black, size: 26),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(
                      text: widget.message.msg!,
                    )).then((value) {
                      Navigator.pop(context);
                    });
                  }),
              if (isMe)
                Divider(
                  color: Colors.black,
                  endIndent: width * .04,
                  indent: width * .04,
                ),
              if (isMe)
                OptionItem(
                    icon: Icon(Icons.delete, color: Colors.black, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      if (mounted) {
                        Navigator.pop(context);
                        await ChatController.my
                            .deleteMessage(widget.message, widget.chatID)
                            .then((value) {
                          // showtoast('Supprimé');
                        });
                      }
                    }),
              Divider(
                color: Colors.black,
                endIndent: width * .04,
                indent: width * .04,
              ),
              OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                  name:
                      'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent!)}',
                  onTap: () {}),
              OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                  name: widget.message.readn == null ||
                          widget.message.readn == ''
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.readn!)}',
                  onTap: () {}),
            ],
          );
        });
  }
}

class OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  OptionItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: width * .05, top: height * .015, bottom: height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: TextStyle(
                        fontSize: 15, color: Colors.black, letterSpacing: 0.5)))
          ]),
        ));
  }
}
