// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorSlot.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:uuid/uuid.dart';

class Calender extends StatefulWidget {
  final DoctorModel model;

  const Calender({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  int index = -1;
  var month = DateFormat('MMMM').format(DateTime.now());
  DateTime date = DateTime.now();
  var height, width;
  DoctorSlot? slots;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Apptheme.primary,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Appointment",
            style: TextStyle(fontSize: 21, color: Colors.white),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    month.toString(),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.17,
                width: width,
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    setState(() {
                      date = selectedDate;
                      month = DateFormat('MMMM').format(selectedDate);
                    });
                  },
                  selectionColor: Apptheme.primary,
                  selectedTextColor: Colors.white,
                  dateTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Slots",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              GetBuilder<LoginController>(
                  id: "slots",
                  builder: (obj) {
                    return SizedBox(
                        height: height * 0.25,
                        width: width,
                        child: date.day.toString() +
                                    date.month.toString() +
                                    date.year.toString() !=
                                DateTime.now().day.toString() +
                                    DateTime.now().month.toString() +
                                    DateTime.now().year.toString()
                            ? Center(
                                child: Text(
                                  "No Slots",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: obj.slotsList.length == 0
                                    ? Center(
                                        child: CustomWidget.largeText(
                                            'Slots not found !'),
                                      )
                                    : GridView.builder(
                                        itemCount: obj.slotsList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 18.0,
                                                mainAxisSpacing: 18.0,
                                                childAspectRatio: 3),
                                        itemBuilder: (context, i) {
                                          DoctorSlot doctorSlot =
                                              obj.slotsList[i];
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                slots = obj.slotsList[i];
                                                index = i;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: index == i
                                                      ? Apptheme.primary
                                                      : Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          21)),
                                              child: Center(
                                                  child: Text(
                                                "${doctorSlot.startTime}",
                                                style: TextStyle(
                                                    color: index == i
                                                        ? Colors.white
                                                        : Apptheme.primary),
                                              )),
                                            ),
                                          );
                                        },
                                      )));
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () async {
                  if (index != -1 && slots != null) {
                    Navigator.pop(context);
                    var uuid = const Uuid();
                    var id = uuid.v4();
                    AppointmentModel model = AppointmentModel(
                        bio: widget.model.bio,
                        id: id,
                        patientid: StaticData.patientmodel!.id,
                        doctorid: widget.model.id,
                        docImage: widget.model.image!,
                        doctername: widget.model.fullname,
                        patientname: StaticData.patientmodel!.fullname,
                        patientimage: StaticData.patientmodel!.image,
                        slotsid: slots!.id,
                        time: slots!.startTime,
                        createdtime: DateTime.now().microsecondsSinceEpoch,
                        status: 1);
                    await StaticData.firebase
                        .collection("appointment")
                        .doc(id)
                        .set(model.toMap());
                    await StaticData.firebase
                        .collection("slots")
                        .doc(widget.model.id)
                        .collection("slots")
                        .doc(slots!.id)
                        .update({"isAvailable": false});

                    await StaticData.firebase
                        .collection("doctor")
                        .doc(widget.model.id)
                        .update({
                      "patientList":
                          FieldValue.arrayUnion([StaticData.patientmodel!.id])
                    });
                    StaticData.sendNotifcation(
                      "Appointment",
                      "Send appointment request from ${StaticData.patientmodel!.fullname} at ${model.time}",
                      widget.model.token,
                    );

                    Fluttertoast.showToast(
                      msg: "Appointment request send sucessfuly !",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                      fontSize: 17,
                      timeInSecForIosWeb: 1,
                      toastLength: Toast.LENGTH_LONG,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "First select Appointment Time !",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                      fontSize: 17,
                      timeInSecForIosWeb: 1,
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.75,
                  child: Center(
                    child: Text(
                      "Confoirm Appointment",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Apptheme.primary,
                      borderRadius: BorderRadius.circular(7)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
