// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:doctor_appointment_app/SQL/Sql_query.dart';
// import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorSlot.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:intl/intl.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController specilest = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController fee = TextEditingController();
  String? startTime;
  String? endTime;
  bool passToggle = true;

  int? maxAppointmentDuration;

  int? index = 1;
  List<String> time = ["10", "20", "30"];
  int select = 0;
  int? duration;
  updateindex(int a) {
    index = a;
    update();
  }

  updateduration(int a) {
    duration = a;
    maxAppointmentDuration = int.tryParse(time[a]);
    update();
  }

  void register(context) async {
    if (startTime != null &&
        endTime != null &&
        maxAppointmentDuration != null) {
      try {
        String id = Uuid().v4();

        DoctorModel model = DoctorModel(
          fee: double.tryParse(fee.text) ?? 0.0,
          ratingperson: 0,
          patientList: [],
          totalrating: 0.0,
          address: address.text,
          email: email.text,
          fullname: fullname.text,
          password: password.text,
          id: id,
          image:await StaticData.assetToF("images/doctor4.png"),
          about: about.text,
          bio: bio.text,
          specialty: specilest.text,
          phonenumber: phonenumber.text,
          endtime: endTime.toString(),
          maxAppointmentDuration: maxAppointmentDuration!,
          starttime: startTime.toString(),
        );
        print("time startTime.toString()${startTime.toString()}");
        print("time endTime.toString()${endTime.toString()}");
           var query="INSERT INTO DoctorModel VALUES (${model.toMap()})";
        SQLQuery.postdata(query)
            .then((value) async {
          String id1 =
              model.id.replaceAll(RegExp(r'[^a-zA-Z]'), '');
          List<DoctorSlot> slots = await generateDoctorSlots(
            
              startTime!, endTime!, maxAppointmentDuration!, id, fullname.text);

          print("object12345");
             var query="CREATE TABLE  ${id1} (id VARCHAR(255) PRIMARY KEY,indexn INT,patientid VARCHAR(255),doctorname VARCHAR(255),doctorid VARCHAR(255),startTime VARCHAR(255),endTime VARCHAR(255),patientName VARCHAR(255),isAvailable bit,date varchar(255));";
        await  SQLQuery.createTabledata(query).then((value) async {
            for (var e in slots) {
                 var query="INSERT INTO ${id1} VALUES (${e.toMap()})";
             await SQLQuery
                  .postdata(query);
            }
          });
          print("object1235678");

          // clearForm();

          var time = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0);
          Duration timeUntilScheduled = time.difference(DateTime.now());

          Timer(timeUntilScheduled, () async {
            print('Task executed at ${DateTime.now()}');
            print("Executing daily task at 12:00 AM");
            List<DoctorSlot> slots1 = await create(
                model.starttime,
                model.endtime,
                model.maxAppointmentDuration,
                id,
                model.fullname);
            print('Initial doctor slots generated at ${DateTime.now()}');

            print("object12345");

            SQLQuery.delecttable(id1).then((value) async {
            await  SQLQuery.createTable3(id1)
                  .then((value) {
                for (var e in slots1) {
                  SQLQuery.postInsertData(id1, e);
                }
              });
            });
          });

          print("object123787990");
        });
        print("object123");

        Fluttertoast.showToast(
          msg: "Signup Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LoginScreen(),
        //     ));
      } catch (e) {
        print("eror${e.toString()}");
        Fluttertoast.showToast(
          msg: "Check internet connecti...or try another email${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "First select Time & Duration !",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void register1(context) async {
    try {
      String id = Uuid().v4();
      PatientModel model = PatientModel(
        email: email.text,
        doctorList: [],
        fullname: fullname.text,
        password: password.text,
        id: id,
        image:await StaticData.assetToF("images/patient_logo.png"),
        phonenumber: phonenumber.text,
      );
   var query="INSERT INTO PatientModel VALUES (${model.toMap()})";
      SQLQuery
          .postdata(query)
          .then((value) {
        // clearForm();
        Fluttertoast.showToast(
          msg: "Signup Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LoginScreen(),
        //     ));
      });
    } catch (e) {
      print("eror${e.toString()}");
      Fluttertoast.showToast(
        msg: "Check internet connecti...or try another email${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  clearForm() {
    fullname.clear();
    phonenumber.clear();
    email.clear();
    password.clear();
    specilest.clear();
    about.clear();
    address.clear();
    bio.clear();
    fee.clear();
    startTime = null;
    endTime = null;
    select = -1;

    update();
  }

  Future<List<DoctorSlot>> generateDoctorSlots(String startTime, String endTime,
      int maxAppointmentDuration, String doctorid, String doctorname) async {
    List<DoctorSlot> doctorSlots = [];
    // try {

   
    DateTime? currentStartTime;
    DateFormat format = DateFormat("h:mm a", 'en_US');

    try {
      print("11111111");
      print("startTime: $startTime");
      currentStartTime = parseTime(startTime);
      print("2222222");
    } catch (e) {
      print('Error parsing time: $e');
    }
int index=0;
    while (currentStartTime!.isBefore(parseTime(endTime))) {
      DateTime currentEndTime =
          currentStartTime.add(Duration(minutes: maxAppointmentDuration));
      var uuid = const Uuid();
      var id = uuid.v4();
      doctorSlots.add(DoctorSlot(
        indexn: index++,
        date: currentStartTime.microsecondsSinceEpoch.toString(),
        doctorid: doctorid,
        doctorname: doctorname,
        id: id.toString(),
        startTime: format.format(currentStartTime),
        endTime: format.format(currentEndTime),
        isAvailable: true,
      ));

      currentStartTime = currentEndTime;
    }
    print("33333333");

    return doctorSlots;
  }

  Future<List<DoctorSlot>> create(String startTime, String endTime,
      int maxAppointmentDuration, String doctorid, String doctorname) async {
    List<DoctorSlot> doctorSlots = [];
    // try {
   
    DateTime? currentStartTime;
    DateFormat format = DateFormat("h:mm a", 'en_US');

    try {
      print("11111111");
      print("startTime: $startTime");
      currentStartTime = parseTime(startTime);
      print("2222222");
    } catch (e) {
      print('Error parsing time: $e');
    }

    while (currentStartTime!.isBefore(parseTime(endTime))) {
      DateTime currentEndTime =
          currentStartTime.add(Duration(minutes: maxAppointmentDuration));
      var uuid = const Uuid();
      var id = uuid.v4();
      doctorSlots.add(DoctorSlot(
        indexn:int.tryParse(DateTime.now().microsecond.toString()),
        date: currentStartTime.microsecondsSinceEpoch.toString(),
        doctorid: doctorid,
        doctorname: doctorname,
        id: id.toString(),
        startTime: format.format(currentStartTime),
        endTime: format.format(currentEndTime),
        isAvailable: true,
      ));

      currentStartTime = currentEndTime;
    }
    print("33333333");
    currentStartTime = null;

    return doctorSlots;
  }

  String addMinutes(String time, int minutes) {
    RegExp regExp = RegExp(r'(\d+):(\d+)(\w+)');

    try {
      RegExpMatch? match = regExp.firstMatch(time);
      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!;

        DateTime dateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          period == 'PM' ? hour + 12 : hour,
          minute,
        );

        dateTime = dateTime.add(Duration(minutes: minutes));
        return DateFormat("h:mm a").format(dateTime);
      } else {
        throw FormatException('Invalid time format');
      }
    } catch (e) {
      print('Error parsing time: $e');
      return time;
    }
  }

  DateTime parseTime(String time) {
    try {
      time = time.trim();

      time = time.replaceAll(RegExp(r'[^a-zA-Z0-9 :]'), '');

      DateFormat format = DateFormat("h:mm a");
      return format.parse(time);
    } catch (e) {
      print('Error parsing time: $e');
      throw e;
    }
  }
}
