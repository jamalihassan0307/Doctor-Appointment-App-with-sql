// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_appointment_app/controller/chatController.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/massagecard.dart';

class ChatScreen extends StatefulWidget {
  final String image;
  final String name;
  final String id;
  final String current;
  final String currentimage;
  final String tokken;
  final String currentname;

  const ChatScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.id,
    required this.current,
    required this.currentimage,
    required this.tokken,
    required this.currentname,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FocusNode _textFocusNode = FocusNode();
  @override
  void initState() {
    Get.put(ChatController());
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    String chatRoomId(String user1, String user2) {
      if (user1[0].toLowerCase().codeUnits[0] >
          user2.toLowerCase().codeUnits[0]) {
        return "$user1$user2";
      } else {
        return "$user2$user1";
      }
    }

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        if (_textFocusNode.hasFocus) {
          _textFocusNode.unfocus();
          return false;
        } else if (ChatController.my.showEmoji) {
          ChatController.my.showEmoji = false;
          ChatController.my.update();
        } else if (!_textFocusNode.hasFocus && !ChatController.my.showEmoji) {}

        return false;
      },
      child: GetBuilder<ChatController>(initState: (state) {
        Get.put(ChatController());
        if (_textFocusNode.hasFocus) {
          _textFocusNode.unfocus();
        }
      }, builder: (obj) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Color(0xFF7165D6),
                leadingWidth: 30,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      SizedBox(
                        width: width * 0.4,
                        child: Text(
                          "${widget.name}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // actions: [
                //   Icon(
                //     Icons.call,
                //     color: Colors.white,
                //     size: 25,
                //   ),
                //   SizedBox(
                //     width: 8,
                //   ),
                //   Icon(
                //     Icons.video_call,
                //     color: Colors.white,
                //     size: 25,
                //   ),
                //   SizedBox(
                //     width: 8,
                //   ),
                //   Icon(
                //     Icons.more_vert,
                //     color: Colors.white,
                //     size: 25,
                //   ),
                // ],
              ),
            ),
            body: Container(
              height: height,
              width: width,
              child: Column(children: [
                Expanded(
                  child: Container(
                    height: height,
                    width: width,
                    child: StreamBuilder(
                      stream: obj.getAllMessages(
                          chatRoomId(widget.id, widget.current)),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            obj.list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            print("obj.list.length ${obj.list.length}");
                            if (obj.list.isNotEmpty) {
                              return ListView.builder(
                                  reverse: true,
                                  itemCount: obj.list.length,
                                  padding: EdgeInsets.only(top: height * .01),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                      message: obj.list[index],
                                      current: widget.current,
                                      chatID:
                                          chatRoomId(widget.id, widget.current),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text("HEELOW THERE! 👋",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              );
                            }
                        }
                      },
                    ),
                  ),
                ),
                _chatInput(obj),
                // if (obj.showEmoji)
                //   SizedBox(
                //     height: height * .35,
                //     child: EmojiPicker(
                //       textEditingController: obj.textController,
                //       config: Config(
                //         bgColor: const Color.fromARGB(255, 234, 248, 255),
                //         columns: 8,
                //         emojiSizeMax: 32 * (1.0),
                //       ),
                //     ),
                //   ),
              ]),
            ));
      }),
    );
  }

  Widget _chatInput(
    ChatController obj,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * .01, horizontal: width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        obj.showEmoji = !obj.showEmoji;
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.grey, size: 25)),

                  Expanded(
                      child: TextField(
                    focusNode: _textFocusNode,
                    controller: obj.textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (obj.showEmoji) {
                        obj.showEmoji = !obj.showEmoji;
                        obj.update();
                      }
                    },
                    onSubmitted: (value) {
                      obj.textController.text.trim();
                      if (obj.textController.text.isNotEmpty) {
                        obj.sendMessage(
                            widget.id,
                            obj.textController.text,
                            widget.current,
                            widget.currentimage,
                            widget.tokken,
                            widget.currentname);

                        obj.textController.text = '';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "type a message ...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.035,
                        ),
                        border: InputBorder.none),
                  )),

                  //adding some space
                  SizedBox(width: width * .02),
                ],
              ),
            ),
          ),
          Container(
            height: height * 0.065,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7],
                colors: [Color(0xffF4866E), Color(0xffEFBF3F)],
              ),
            ),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    obj.textController.text.trim();
                    if (obj.textController.text.isNotEmpty) {
                      obj.sendMessage(
                          widget.id,
                          obj.textController.text,
                          widget.current,
                          widget.currentimage,
                          widget.tokken,
                          widget.currentname);

                      obj.textController.text = '';
                    }
                  },
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
      ),
    );
  }
}
