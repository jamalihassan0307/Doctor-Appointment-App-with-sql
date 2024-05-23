import 'dart:convert';

import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
// import 'package:doctor_appointment_app/controller/patient/patientController.dart';
import 'package:doctor_appointment_app/screens/patient/appointment_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height, width;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${StaticData.patientmodel!.fullname}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: MemoryImage(
                          base64Decode(StaticData.patientmodel!.image))),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    StaticData.openEmailChat();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0EEFA),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.email,
                            color: Apptheme.primary,
                            size: 35,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          " Email",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Contact to Clinic",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String user1 = "1fd0278c-d841-4a1e-8ea2-b7e874237569";
                    String user2 = "15617030-613d-497a-944b-9810bec14c4c";
                    String a = StaticData.chatRoomId(user1, user2);
                    String id1 =
                        a.substring(0, 20).replaceAll(RegExp(r'[^a-zA-Z]'), '');
                    print("data1${a}  sdsf${id1}");
                    print("2qweqweqeqeqwe        ${a}");
                    // StaticData.openWhatsAppChat();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0EEFA),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chat,
                            color: Color(0xFF7165D6),
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "WhatsApp",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Contact to Clinic",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Popular Doctors",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: Colors.black54,
                ),
              ),
            ),
            Center(child: GetBuilder<LoginController>(builder: (obj) {
              return SizedBox(
                width: width * 0.95,
                child: obj.alldoctor.length == 0
                    ? Center(
                        child: CustomWidget.largeText('Data not found !'),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 0),
                        itemCount: obj.alldoctor.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context1, index) {
                          var model = obj.alldoctor[index];
                          return InkWell(
                            onTap: () {
                              model = obj.alldoctor[index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentScreen(model: model),
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        MemoryImage(base64Decode(model.image!)),
                                  ),
                                  Text(
                                    "Dr.${model.fullname}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "${model.specialty}",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color:
                                            Color.fromARGB(255, 236, 182, 18),
                                        size: 11,
                                      ),
                                      Text(
                                        "Ratting:${(model.totalrating / model.ratingperson).isNaN ? "0" : (model.totalrating / model.ratingperson)}",
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
