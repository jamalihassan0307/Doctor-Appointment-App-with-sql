// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctor_appointment_app/controller/admin/admin_chat_Controller.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/screens/massage/m_date_util.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';

import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:get/get.dart';

class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminMessagesScreen> createState() => _AdminMessagesScreenState();
}

class _AdminMessagesScreenState extends State<AdminMessagesScreen> {
  @override
  void initState() {
    Get.put(AdminChatController());
    StaticData.updatedoctorprofile()
        .then((value) => AdminChatController.to.getpatient());
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<AdminChatController>(builder: (obj) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
            obj.patientList.length == 0
                ? SizedBox(
                    height: height * 0.8,
                    child: Center(
                      child: CustomWidget.largeText('No Patient !'),
                    ),
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: obj.patientList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: StaticData.firebase
                              .collection('chatroom')
                              .doc(StaticData.chatRoomId(
                                  obj.patientList[index].id,
                                  StaticData.doctorModel!.id))
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
                              message = Message.fromJson(
                                  snapshot.data!.docs[0].data());
                            }

                            List<Message> unread = snapshot.data!.docs
                                .map((doc) => Message.fromJson(doc.data()))
                                .where((message) => message.read == "")
                                .where((element) =>
                                    message!.fromId !=
                                    StaticData.doctorModel!.id)
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
                                                image: obj
                                                    .patientList[index].image,
                                                name: obj.patientList[index]
                                                    .fullname,
                                                id: obj.patientList[index].id,
                                                current:
                                                    StaticData.doctorModel!.id,
                                                currentimage: StaticData
                                                    .doctorModel!.image!,
                                                currentname: StaticData
                                                    .doctorModel!.fullname,
                                                tokken: obj
                                                    .patientList[index].token,
                                              ),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            "${obj.patientList[index].image}"),
                                      ),
                                      title: Text(
                                        "${obj.patientList[index].fullname}",
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
                                                    .patientList[index].image,
                                                name: obj.patientList[index]
                                                    .fullname,
                                                id: obj.patientList[index].id,
                                                current:
                                                    StaticData.doctorModel!.id,
                                                currentimage: StaticData
                                                    .doctorModel!.image!,
                                                currentname: StaticData
                                                    .doctorModel!.fullname,
                                                tokken: obj
                                                    .patientList[index].token,
                                              ),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            "${obj.patientList[index].image}"),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width * 0.20,
                                            child: Text(
                                              "${obj.patientList[index].fullname}",
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
                          });
                    },
                  ),
          ],
        ),
      );
    });
  }
}
