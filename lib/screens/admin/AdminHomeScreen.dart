import 'dart:convert';

import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/patient_profile.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var height, width;
  @override
  void initState() {
    Get.put(AdminHomeController());
    StaticData.updatedoctorprofile();
    AdminHomeController.to.getSchedule();
    super.initState();
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<AdminHomeController>(builder: (obj) {
      return Material(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 25),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.70,
                        child: Text(
                          "Dr.${StaticData.doctorModel!.fullname}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: MemoryImage(
                            base64Decode(StaticData.doctorModel!.image!)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${StaticData.doctorModel!.patientList!.length}",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: Apptheme.primary),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total patient",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Apptheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {},
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${obj.schedule}",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: Apptheme.primary),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "  Schedule  ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Apptheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "All Patients",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.95,
                    child: StaticData.doctorModel!.patientList!.length == 0
                        ? SizedBox(
                            height: height * 0.4,
                            child: Center(
                              child: CustomWidget.largeText('No Patient !'),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.1),
                            itemCount:
                                StaticData.doctorModel!.patientList!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return StreamBuilder(
                                stream: StaticData.firebase
                                    .collection('patient')
                                    .doc(StaticData
                                        .doctorModel!.patientList![index])
                                    .snapshots(),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    print("Error: /${snapshot.error}");
                                    return Text('Error: /${snapshot.error}');
                                  }

                                  PatientModel? patientModel =
                                      PatientModel.fromMap(snapshot.data!.data()
                                          as Map<String, dynamic>);

                                  return !snapshot.data!.exists
                                      ? Center(
                                          child: CustomWidget.largeText(
                                              'Data not found !'),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            patientModel = PatientModel.fromMap(
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientProfile(
                                                          model: patientModel!),
                                                ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      "${patientModel.image}"),
                                                ),
                                                Text(
                                                  "${patientModel.fullname}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                Text(
                                                  "ph:${patientModel.phonenumber}",
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
