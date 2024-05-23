// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:doctor_appointment_app/controller/patient/patientChatController.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:doctor_appointment_app/screens/massage/m_date_util.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
   
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<PatientChatController>(builder: (obj) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Center(
                    child: Text(
                      "Messages",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                obj.doctorlist.length == 0
                    ? SizedBox(
                        height: height * 0.8,
                        child: Center(
                          child: CustomWidget.largeText('No Doctor !'),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: obj.doctorlist.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var message;
                          List<Message> unread = [];
                          if (obj.messageList.isNotEmpty &&
                              obj.messageList[index]![0] != null) {
                            message = obj.messageList[index]!.last!;
                            // unread!.clear();
                            // unread = obj.messageList[index]!
                            //     .map((doc) => Message.fromJson(doc))
                            //     .where((message) => message.readS == "")
                            //     .where((element) =>
                            //         message!.fromId !=
                            //         StaticData.patientmodel!.id)
                            //     .toList();
                          } else {}
                          if (obj.doctorlist.isEmpty) {
                            return SizedBox(
                              height: height * 0.8,
                              child: Center(
                                child: CustomWidget.largeText('No Patient !'),
                              ),
                            );
                          } else {
                            return obj.messageList.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                image: obj
                                                    .doctorlist[index].image!,
                                                name: obj
                                                    .doctorlist[index].fullname,
                                                id: obj.doctorlist[index].id,
                                                current:
                                                    StaticData.patientmodel!.id,
                                                currentimage: StaticData
                                                    .patientmodel!.image,
                                                currentname: StaticData
                                                    .patientmodel!.fullname,
                                                tokken:
                                                    obj.doctorlist[index].token,
                                              ),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: MemoryImage(base64Decode(
                                            "${obj.doctorlist[index].image}")),
                                      ),
                                      title: Text(
                                        "${obj.doctorlist[index].fullname}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                      trailing: Text(
                                        "12:30 pm",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 5),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                image: obj
                                                    .doctorlist[index].image!,
                                                name: obj
                                                    .doctorlist[index].fullname,
                                                id: obj.doctorlist[index].id,
                                                current:
                                                    StaticData.patientmodel!.id,
                                                currentimage: StaticData
                                                    .patientmodel!.image,
                                                currentname: StaticData
                                                    .patientmodel!.fullname,
                                                tokken:
                                                    obj.doctorlist[index].token,
                                              ),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: MemoryImage(base64Decode(
                                            "${obj.doctorlist[index].image}")),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width * 0.30,
                                            child: Text(
                                              "${obj.doctorlist[index].fullname}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.30,
                                            child: Text(
                                              "${MyDateUtil.getMessageTime(context: context, time: message!.sent!)}",
                                              style: TextStyle(
                                                fontSize: 14,
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
                                            width: width * 0.25,
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
                                              padding: const EdgeInsets.only(
                                                  right: 40),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Apptheme.primary,
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
                          }
                        },
                      ),
              ],
            ),
          ),
          if (obj.loading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      );
    });
  }
}
