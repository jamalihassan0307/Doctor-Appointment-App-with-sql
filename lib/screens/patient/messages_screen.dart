// ignore_for_file: must_be_immutable

// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/controller/patient/patientChatController.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:doctor_appointment_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
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

                      SizedBox(width: width * 0.02),
                      SizedBox(width: width * 0.02),
                      InkWell(
                          onTap: () {
                            obj.updatejoining();
                          },
                          child: Icon(Icons.done_all)),
                      SizedBox(width: width * 0.02),
                      PopupMenuButton<String>(
                        color: Colors.white,
                        onSelected: (String result) {
                          if (obj.doctorlistjoining.isNotEmpty &&
                              obj.doctorlistjoining.length == 2) {
                            obj.selectJoinType(result);
                            print("sdhdsi");
                          } else {
                            Fluttertoast.showToast(
                              msg: "At least 2 users are required for joining!",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 17,
                              timeInSecForIosWeb: 1,
                              toastLength: Toast.LENGTH_LONG,
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Left Join',
                            child: Text('Left Join'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Right Join',
                            child: Text('Right Join'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Inner Join',
                            child: Text('Inner Join'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'FULL OUTER Join',
                            child: Text('FULL OUTER Join'),
                          ),
                        ],
                      ),

                      // InkWell(
                      //   onTap: (){
                      //     PatientChatController.to.getdoctor().then((value) {
                      //       setState(() {

                      //       });
                      //     });
                      //   },
                      //   child: Icon(Icons.refresh))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (!obj.sms)
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
                            // var message;
                            // List<Message> unread = [];
                            // if (obj.messageList.isNotEmpty &&
                            //     obj.messageList[index]![0] != null) {
                            // message = obj.messageList[index]!.last!;
                            // unread!.clear();
                            // unread = obj.messageList[index]!
                            //     .map((doc) => Message.fromJson(doc))
                            //     .where((message) => message.readS == "")
                            //     .where((element) =>
                            //         message!.fromId !=
                            //         StaticData.patientmodel!.id)
                            //     .toList();
                            // } else {}
                            if (obj.doctorlist.isEmpty) {
                              return SizedBox(
                                height: height * 0.8,
                                child: Center(
                                  child: CustomWidget.largeText('No Patient !'),
                                ),
                              );
                            } else {
                              return
                                  //  obj.messageList.isEmpty
                                  //     ?
                                  Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  onTap: () {
                                    var model = obj.doctorlist[index];
                                    if (obj.joining) {
                                      if (!obj.doctorlistjoining.any(
                                          (element) =>
                                              element.id ==
                                              obj.doctorlist[index].id)) {
                                        obj.doctorlistjoining
                                            .add(obj.doctorlist[index]);
                                        obj.update();
                                      } else {
                                        obj.doctorlistjoining.removeWhere(
                                            (element) =>
                                                element.id ==
                                                obj.doctorlist[index].id);
                                        obj.update();
                                      }
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                              image: model.image!,
                                              name: model.fullname,
                                              id: model.id,
                                              current:
                                                  StaticData.patientmodel!.id,
                                              currentimage: StaticData
                                                  .patientmodel!.image,
                                              currentname: StaticData
                                                  .patientmodel!.fullname,
                                            ),
                                          ));
                                    }
                                  },
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (obj.joining)
                                        if (!obj.doctorlistjoining.any(
                                            (element) =>
                                                element.id ==
                                                obj.doctorlist[index].id))
                                          Icon(Icons.radio_button_off),
                                      if (obj.joining)
                                        if (obj.doctorlistjoining.any(
                                            (element) =>
                                                element.id ==
                                                obj.doctorlist[index].id))
                                          Icon(Icons.radio_button_checked,
                                              color: Apptheme.primary),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: FileImage(File(
                                            "${obj.doctorlist[index].image}")),
                                      ),
                                    ],
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
                                    "--- pm",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              );
                              // : Padding(
                              //     padding: const EdgeInsets.only(
                              //         bottom: 2, right: 5),
                              //     child: ListTile(
                              //       onTap: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => ChatScreen(
                              //                 image: obj
                              //                     .doctorlist[index].image!,
                              //                 name: obj
                              //                     .doctorlist[index].fullname,
                              //                 id: obj.doctorlist[index].id,
                              //                 current:
                              //                     StaticData.patientmodel!.id,
                              //                 currentimage: StaticData
                              //                     .patientmodel!.image,
                              //                 currentname: StaticData
                              //                     .patientmodel!.fullname,
                              //                 tokken:
                              //                     obj.doctorlist[index].token,
                              //               ),
                              //             ));
                              //       },
                              //       leading: CircleAvatar(
                              //         radius: 30,
                              //         backgroundImage: FileImage(
                              // File("${obj.doctorlist[index].image}")),
                              //       ),
                              //       title: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(
                              //             width: width * 0.30,
                              //             child: Text(
                              //               "${obj.doctorlist[index].fullname}",
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 16,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 color: Colors.black54,
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             width: width * 0.30,
                              //             child: Text(
                              //               "${MyDateUtil.getMessageTime(context: context, time: message!.sent!)}",
                              //               style: TextStyle(
                              //                 fontSize: 14,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 color: Colors.black54,
                              //               ),
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //       subtitle: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(
                              //             width: width * 0.25,
                              //             child: Text(
                              //               "${message.msg}",
                              //               maxLines: 1,
                              //               overflow: TextOverflow.ellipsis,
                              //               style: TextStyle(
                              //                 fontSize: 16,
                              //                 color: Colors.black54,
                              //               ),
                              //             ),
                              //           ),
                              //           if (unread.length != 0)
                              //             Padding(
                              //               padding: const EdgeInsets.only(
                              //                   right: 40),
                              //               child: CircleAvatar(
                              //                 backgroundColor:
                              //                     Apptheme.primary,
                              //                 child: Text(
                              //                   unread.length < 99
                              //                       ? "${unread.length}"
                              //                       : "99+",
                              //                   style: TextStyle(
                              //                       color: Colors.white),
                              //                 ),
                              //                 radius: 15,
                              //               ),
                              //             )
                              //         ],
                              //       ),
                              //     ),
                              //   );
                            }
                          },
                        ),
                if (obj.sms)
                  obj.read.length == 0
                      ? SizedBox(
                          height: height * 0.8,
                          child: Center(
                            child: CustomWidget.largeText('No SMS !'),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: obj.read.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Message model = obj.read[index];
                            return Padding(
                              padding: EdgeInsetsDirectional.all(8),
                              child: ListTile(
                                leading: model.fromId == StaticData.patient ||
                                        model.fromId == StaticData.doctor
                                    ? CircleAvatar(
                                        backgroundColor: Apptheme.primary,
                                        child: Center(
                                          child: Text(
                                            "U",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Apptheme.primary,
                                        child: Center(
                                          child: Text(
                                            "O",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                title: Text(model.msg!),
                              ),
                            );
                          })
              ],
            ),
          ),
          if (obj.loading == true)
            Center(
              child: SizedBox(
                height: height * 0.1,
                width: width * 0.2,
                child: SpinKit.loadSpinkit,
              ),
            ),
        ],
      );
    });
  }
}
