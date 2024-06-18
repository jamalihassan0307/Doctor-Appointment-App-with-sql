// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AdminUpcomingSchedule extends StatefulWidget {
  const AdminUpcomingSchedule({Key? key}) : super(key: key);

  @override
  State<AdminUpcomingSchedule> createState() => _AdminUpcomingScheduleState();
}

class _AdminUpcomingScheduleState extends State<AdminUpcomingSchedule> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<AdminHomeController>(
        id: "AppointmentModel",
        builder: (obj) {
          return SizedBox(
              height: height * 0.65,
              width: width,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: obj.requested.isEmpty
                      ? Center(
                          child: CustomWidget.largeText('Data not found !'),
                        )
                      : ListView.builder(
                          itemCount: obj.requested.length,
                          itemBuilder: (context, index) {
                            var model = obj.requested[index];
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
                                          // subtitle: Text("${model!.bio}"),
                                          trailing: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: FileImage(
                                                File(model.patientimage)),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                                "Pending",
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              model = obj.requested[index];

                                              obj.updateAppointmentStatus(
                                                  model.id, 0);
                                              obj.updateList(
                                                  model.id, 0, model);
                                              // obj.getSchedule();

                                              obj.updateSlotsStatus(
                                                  model.doctorid,
                                                  model.slotsid,
                                                  1);
                                              // obj.getAllAppointment();
                                            },
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF4F6FA),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              model = obj.requested[index];

                                              obj.updateAppointmentStatus(
                                                  model.id, 2);
                                              obj.updateList(
                                                  model.id, 2, model);

                                              // obj
                                              //     .getpatienttokken(model.patientid)
                                              //     .then((value) {
                                              // StaticData.sendNotifcation(
                                              //     "Appointment",
                                              //     "${model.doctername} accept your appointment at ${model.time}",
                                              //     obj.patienttokken!);
                                              // });
                                            },
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF7165D6),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )));
        });
  }
}
