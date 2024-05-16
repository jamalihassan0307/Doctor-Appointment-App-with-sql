// ignore_for_file: must_be_immutable

import 'package:doctor_appointment_app/controller/patient/patientChatController.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:doctor_appointment_app/screens/massage/m_date_util.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    Get.put(PatientChatController());
    StaticData.updatepatientprofile()
        .then((value) => PatientChatController.to.getdoctor());
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<PatientChatController>(builder: (obj) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    "Chat Us",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: obj.doctorlist.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: StaticData.firebase
                          .collection('chatroom')
                          .doc(StaticData.chatRoomId(obj.doctorlist[index].id,
                              StaticData.patientmodel!.id))
                          .collection("chats")
                          .orderBy("sent", descending: true)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          print("Error: /${snapshot.error}");
                          return Text('Error: /${snapshot.error}');
                        }
                        Message? message;
                        if (snapshot.data!.docs.length != 0) {
                          message =
                              Message.fromJson(snapshot.data!.docs[0].data());
                        }

                        List<Message> unread = snapshot.data!.docs
                            .map((doc) => Message.fromJson(doc.data()))
                            .where((message) => message.read == "")
                            .where((element) =>
                                message!.toId != StaticData.patientmodel!.id)
                            .toList();

                        if (snapshot.data!.docs.length != 0)
                          print(
                              'snapshot.data!.docs.length/${snapshot.data!.docs.length}');
                        return snapshot.data!.docs.length == 0 &&
                                snapshot.data!.docs.isEmpty &&
                                message == null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            image: obj.doctorlist[index].image!,
                                            name:
                                                obj.doctorlist[index].fullname,
                                            id: obj.doctorlist[index].id,
                                            current:
                                                StaticData.patientmodel!.id,
                                            currentimage:
                                                StaticData.patientmodel!.image,
                                            currentname: StaticData
                                                .patientmodel!.fullname,
                                            tokken: obj.doctorlist[index].token,
                                          ),
                                        ));
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "${obj.doctorlist[index].image}"),
                                  ),
                                  title: Text(
                                    "${obj.doctorlist[index].fullname}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Hello, Doctor are your there?",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            image: obj.doctorlist[index].image!,
                                            name:
                                                obj.doctorlist[index].fullname,
                                            id: obj.doctorlist[index].id,
                                            current:
                                                StaticData.patientmodel!.id,
                                            currentimage:
                                                StaticData.patientmodel!.image,
                                            currentname: StaticData
                                                .patientmodel!.fullname,
                                            tokken: obj.doctorlist[index].token,
                                          ),
                                        ));
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        "${obj.doctorlist[index].image}"),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.45,
                                        child: Text(
                                          "${obj.doctorlist[index].fullname}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 18,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.2,
                                        child: Text(
                                          "${MyDateUtil.getMessageTime(context: context, time: message!.sent!)}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.5,
                                        child: Text(
                                          "${message.msg}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      if (unread.length != 0)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: CircleAvatar(
                                            backgroundColor: Apptheme.primary,
                                            child: Text(
                                              unread.length < 99
                                                  ? "${unread.length}"
                                                  : "99+",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            radius: 15,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              );
                      });
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
