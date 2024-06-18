// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/controller/patient/patientChatController.dart';
import 'package:doctor_appointment_app/screens/massage/chat_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/screens/patient/bookappointment.dart';

class AppointmentScreen extends StatefulWidget {
  final DoctorModel model;
  const AppointmentScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  var height, width;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    LoginController.to.getdoctorSlotes(widget.model.id);
    return Scaffold(
      backgroundColor: Color(0xFF7165D6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage:
                                FileImage(File(widget.model.image!)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Dr.${widget.model.fullname}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            "${widget.model.email}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${widget.model.phonenumber}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            image: widget.model.image!,
                                            name: widget.model.fullname,
                                            id: widget.model.id,
                                            current:
                                                StaticData.patientmodel!.id,
                                            currentimage:
                                                StaticData.patientmodel!.image,
                                            currentname: StaticData
                                                .patientmodel!.fullname),
                                      ));
                                  try {
                                    await LoginController.to
                                        .getDoctorId(widget.model.id)
                                        .then((model) async {
                                      if (LoginController.to.getdoctor !=
                                          null) {
                                        print(
                                            "model234${LoginController.to.getdoctor.toString()}");
                                        print(
                                            "model23424${LoginController.to.getdoctor!.patientList!.contains(
                                          StaticData.patientmodel!.id,
                                        )}");
                                        if (LoginController
                                                .to.getdoctor!.patientList!
                                                .contains(
                                              StaticData.patientmodel!.id,
                                            ) ==
                                            false) {
                                          widget.model.patientList!
                                              .add(StaticData.patientmodel!.id);
                                          String query =
                                              "UPDATE DoctorModel SET ";
                                          query +=
                                              "patientList = '${json.encode(widget.model.patientList)}'";

                                          query +=
                                              " WHERE id = '${widget.model.id}'";
                                          if (StaticData.localdatabase) {
                                            try {
                                              var map = {
                                                'patientList':
                                                    '${json.encode(widget.model.patientList)}'
                                              };
                                              var result =
                                                  await SQLService.updateData(
                                                      'DoctorModel',
                                                      map,
                                                      widget.model.id);
                                              print(
                                                  "resultresult${result.toString()}");
                                            } catch (e) {
                                              print(
                                                  "Error in updateprofile: $e");
                                            }
                                          } else {
                                            try {
                                              var result =
                                                  await SQL.Update(query);
                                              print(
                                                  "resultresult${result.toString()}");
                                            } catch (e) {
                                              print(
                                                  "Error in updateprofile: $e");
                                            }
                                          }
                                        } else {
                                          print("id presnt");
                                        }
                                      } else {
                                        print("null");
                                      }
                                    });
                                    LoginController.to
                                        .getPatientId(
                                            StaticData.patientmodel!.id)
                                        .then((model1) async {
                                      print(
                                          "model${LoginController.to.getpatient.toString()}");
                                      if (!LoginController
                                          .to.getpatient!.doctorList
                                          .contains(widget.model.id)) {
                                        LoginController
                                            .to.getpatient!.doctorList
                                            .add(widget.model.id);

                                        String query =
                                            "UPDATE PatientModel SET ";
                                        query +=
                                            "doctorList = '${json.encode(LoginController.to.getpatient!.doctorList)}'";

                                        query +=
                                            " WHERE id = '${StaticData.patientmodel!.id}'";
                                        if (StaticData.localdatabase) {
                                          try {
                                            var map = {
                                              'doctorList':
                                                  '${json.encode(LoginController.to.getpatient!.doctorList)}'
                                            };
                                            var result =
                                                await SQLService.updateData(
                                                    'PatientModel',
                                                    map,
                                                    StaticData
                                                        .patientmodel!.id);
                                            print(
                                                "resultresult${result.toString()}");
                                          } catch (e) {
                                            print("Error in updateprofile: $e");
                                          }
                                        } else {
                                          try {
                                            var result =
                                                await SQL.Update(query);
                                            print(
                                                "resultresult${result.toString()}");
                                          } catch (e) {
                                            print("Error in updateprofile: $e");
                                          }
                                        }
                                        String name = StaticData.chatRoomId(
                                            widget.model.id,
                                            StaticData.patientmodel!.id);
                                        StaticData.patientmodel!.doctorList
                                            .add(widget.model.id);
                                        PatientChatController.to.doctorlist
                                            .add(widget.model);

                                        String id1 = name.replaceAll(
                                            RegExp(r'[^a-zA-Z]'), '');
                                        SQLQuery.createTable2(id1);
                                      } else {
                                        print("id presnt");
                                      }
                                    });
                                  } catch (e) {}
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9F97E2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.chat_bubble_text_fill,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(160),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "About Doctor",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      "${widget.model.about}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Appointment",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // SizedBox(
                    //     height: height * 0.25,
                    //     child: StreamBuilder(
                    //         stream: StaticData.firebase
                    //             .collection('appointment')
                    //             .where("doctorid", isEqualTo: widget.model.id)
                    //             .snapshots(),
                    //         builder: (BuildContext context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //               ConnectionState.waiting) {
                    //             return  Center(
                    // child: SizedBox(
                    //   height: height * 0.1,
                    //   width: width * 0.2,
                    //   child: SpinKit.loadSpinkit,
                    // ),),;
                    //           }

                    //           if (snapshot.hasError) {
                    //             print("Error: /${snapshot.error}");
                    //             return Text('Error: /${snapshot.error}');
                    //           }

                    //           AppointmentModel? appointmentModel;
                    //           if (snapshot.data!.docs.length != 0)
                    //             print(
                    //                 'snapshot.data!.docs.length/${snapshot.data!.docs.length}');
                    //           return snapshot.data!.docs.length == 0 &&
                    //                   snapshot.data!.docs.isEmpty
                    //               ? Center(
                    //                   child: CustomWidget.largeText(
                    //                       'Data not found !'),
                    //                 )
                    //               : ListView.builder(
                    //                   itemCount: snapshot.data!.docs.length,
                    //                   scrollDirection: Axis.horizontal,
                    //                   itemBuilder:
                    //                       (BuildContext context, int index) {
                    //                     appointmentModel =
                    //                         AppointmentModel.fromMap(snapshot
                    //                             .data!.docs[index]
                    //                             .data());
                    //                     return Container(
                    //                       width: width * 0.7,
                    //                       margin: EdgeInsets.all(10),
                    //                       padding:
                    //                           EdgeInsets.symmetric(vertical: 5),
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.white,
                    //                         borderRadius:
                    //                             BorderRadius.circular(40),
                    //                         boxShadow: [
                    //                           BoxShadow(
                    //                             color: Colors.black12,
                    //                             blurRadius: 4,
                    //                             spreadRadius: 2,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       child: SizedBox(
                    //                         child: Column(
                    //                           children: [
                    //                             ListTile(
                    //                               leading: CircleAvatar(
                    //                                 radius: 30,
                    //                                 backgroundImage: NetworkImage(
                    //                                     "${appointmentModel!.patientimage}"),
                    //                               ),
                    //                               title: Text(
                    //                                 " ${appointmentModel!.patientname}",
                    //                                 style: TextStyle(
                    //                                   fontWeight:
                    //                                       FontWeight.bold,
                    //                                 ),
                    //                               ),
                    //                               subtitle: Text(GetTimeAgo.parse(
                    //                                       microsecondsSinceEpochToDateTime(
                    //                                           appointmentModel!
                    //                                               .createdtime))
                    //                                   .toString()),
                    //                             ),
                    //                             SizedBox(
                    //                               height: 5,
                    //                             ),
                    //                             Padding(
                    //                               padding: EdgeInsets.symmetric(
                    //                                   horizontal: 10),
                    //                               child: Text(
                    //                                 maxLines: 2,
                    //                                 overflow:
                    //                                     TextOverflow.ellipsis,
                    //                                 "${appointmentModel!.time}",
                    //                                 style: TextStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 13,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Padding(
                    //                               padding: EdgeInsets.symmetric(
                    //                                   horizontal: 10),
                    //                               child: Text(
                    //                                 maxLines: 2,
                    //                                 overflow:
                    //                                     TextOverflow.ellipsis,
                    //                                 "${appointmentModel!.rating}",
                    //                                 style: TextStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 13,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 );
                    //         })),

                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EEFA),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFF7165D6),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "${widget.model.address}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("address of the medical center,"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: height * 0.16,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Consultation Price",
                  style: TextStyle(
                    color: Color.fromARGB(115, 2, 11, 66),
                  ),
                ),
                Text(
                  "Rs = ${widget.model.fee} ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Calender(
                              model: widget.model,
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime microsecondsSinceEpochToDateTime(int microsecondsSinceEpoch) {
    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }
}
