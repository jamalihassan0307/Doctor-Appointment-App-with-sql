// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/SQL/signalr.dart';
import 'package:doctor_appointment_app/controller/admin/admin_chat_Controller.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';

import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
   
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<AdminChatController>(builder: (obj) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            LiveServer.Connect();
                          },
                          child: Text(
                            "Messages1",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width:width*0.02),
                     InkWell(
                        onTap: (){

                         obj.updatejoining();
                        },
                        child: Icon(Icons.done_all)),
                        SizedBox(width:width*0.02),
                       PopupMenuButton<String>(
                        color: Colors.white,

            onSelected: (String result) {
              if (obj.patientListjoining.isNotEmpty && obj.patientListjoining.length == 2) {
                 obj.selectJoinType(result);
              } else {
                  Fluttertoast.showToast(
      msg: "At least 2 users are required for joining!",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      fontSize: 17,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_LONG,
    );}
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                    //  InkWell(
                    //     onTap: (){
                    //      obj.getpatientmessageRead(false);
                       
                    //     },
                    //     child: Icon(Icons.done_all,color: Colors.blue,),),
                    //         SizedBox(width:width*0.02),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if(!obj.sms)
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
                          // var message = obj.messageList[index]![0];
                          // List<Message> unread = [];
                          // if (obj.messageList.isNotEmpty &&
                          //     obj.messageList[index]![0] != null) {
                          //   message = obj.messageList[index]!.last!;
                            // unread!.clear();
                            // unread = obj.messageList[index]!
                            //     .map((doc) => Message.fromJson(doc))
                            //     .where((message) => message.readS == "")
                            //     .where((element) =>
                            //         message!.fromId !=
                            //         StaticData.doctorModel!.id)
                            //     .toList();
                          // } else {}
                          if (obj.patientList.isEmpty) {
                            return SizedBox(
                              height: height * 0.8,
                              child: Center(
                                child: CustomWidget.largeText('No Patient !'),
                              ),
                            );
                          } else {
                            return
                            //  obj.messageList[index]!.isEmpty
                            //     ?
                                 Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ListTile(
                                      onTap: () {
                                        if(obj.joining)
                                          
                                       {
if(!obj.patientListjoining.any((element) => element.id==obj.patientList[index].id)){
  obj.patientListjoining.add(obj.patientList[index]);
  obj.update();
}else{
obj.patientListjoining.removeWhere((element) => element.id==obj.patientList[index].id);
obj.update();}
                                       }else{
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
                                              
                                              ),
                                            ));
                                       }
                                    
                                      },
                                      leading: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if(obj.joining)
                                          if(!obj.patientListjoining.any((element) => element.id==obj.patientList[index].id))
                                           Icon(Icons.radio_button_off),
                                          if(obj.joining)
                                          if(obj.patientListjoining.any((element) => element.id==obj.patientList[index].id))
                                           Icon(Icons.radio_button_checked,color: Apptheme.primary),
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: FileImage(File(
                                                "${obj.patientList[index].image}")),
                                          ),
                                        ],
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
                                        "----- pm",
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
                                //                     .patientList[index].image,
                                //                 name: obj.patientList[index]
                                //                     .fullname,
                                //                 id: obj.patientList[index].id,
                                //                 current:
                                //                     StaticData.doctorModel!.id,
                                //                 currentimage: StaticData
                                //                     .doctorModel!.image!,
                                //                 currentname: StaticData
                                //                     .doctorModel!.fullname,
                                //                 tokken: obj
                                //                     .patientList[index].token,
                                //               ),
                                //             ));
                                //       },
                                //       leading: CircleAvatar(
                                //         radius: 30,
                                //         backgroundImage:FileImage(
                                                        // File(
                                //             "${obj.patientList[index].image}")),
                                //       ),
                                //       title: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           SizedBox(
                                //             width: width * 0.30,
                                //             child: Text(
                                //               "${obj.patientList[index].fullname}",
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
            if(obj.sms)
            obj.read.length==0?
            SizedBox(
                        height: height * 0.8,
                        child: Center(
                          child: CustomWidget.largeText('No SMS !'),
                        ),
                      ):
                      ListView.builder(
                        
                            physics: NeverScrollableScrollPhysics(),
                        itemCount: obj.read.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Message model=obj.read[index];
                          return Padding(padding: EdgeInsetsDirectional.all(8),
                          child: ListTile(
                            leading:  model.fromId==StaticData.patient
                            ||model.fromId==StaticData.doctor?CircleAvatar(
                              backgroundColor: Apptheme.primary,
                              child: Center(
                                child: Text("U",style: 
                                TextStyle(fontSize: 22,color: Colors.white),),
                              ),
                            ):CircleAvatar(
                              backgroundColor: Apptheme.primary,
                              child: Center(
                                child: Text("O",style: 
                                TextStyle(fontSize: 22,color: Colors.white),),
                              ),
                            ),
                            title:Text(model.msg!),
                          ),
                          );
     } )
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
