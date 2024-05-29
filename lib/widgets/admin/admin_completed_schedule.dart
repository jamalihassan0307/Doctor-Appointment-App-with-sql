// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
// import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCompletedSchedule extends StatefulWidget {
  const AdminCompletedSchedule({super.key});

  @override
  State<AdminCompletedSchedule> createState() => _AdminCompletedScheduleState();
}

class _AdminCompletedScheduleState extends State<AdminCompletedSchedule> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<AdminHomeController>(builder: (obj) {
      return SizedBox(
        height: height * 0.65,
        width: width,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: obj.confirmed.isEmpty
                ? Center(
                    child: CustomWidget.largeText('Data not found !'),
                  )
                : ListView.builder(
                    itemCount: obj.confirmed.length,
                    itemBuilder: (context, index) {
                      var model = obj.confirmed[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text(
                                      "${model.patientname}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // subtitle: Text("${model!.time}"),
                                    trailing:  CircleAvatar(
                                            radius: 25,
                                            backgroundImage:FileImage(
                                                        File(
                                                    model.patientimage)),
                                          )),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Divider(
                                    thickness: 1,
                                    height: 20,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${StaticData.formatMicrosecondsSinceEpoch(model.createdtime)}",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${model.time}",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Completed",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
      );
    });
  }
}
