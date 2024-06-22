// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
class StaticData {
  static bool localdatabase = true;
  static Future<String> assetToF(String assetPath) async {
    String directory = (await getTemporaryDirectory()).path;
    List<String> pathParts = assetPath.split('/');
    String fileName = pathParts.last;
    String filePath = '$directory/$fileName';
    File existingFile = File(filePath);
    if (await existingFile.exists()) {
      return existingFile.path;
    } else {
      ByteData data = await rootBundle.load(assetPath);
      Uint8List bytes = data.buffer.asUint8List();
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      return file.path;
    }
  }

  static String patient = "";
  static String doctor = "";
  static DoctorModel? doctorModel;
  static PatientModel? patientmodel;
  static String token = "";
  static http.Response? response;

  static Future<bool> updateSlotsStatus(
      String database, String id, int status) async {
    try {
      String id1 = database.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      SQLQuery.updateSlotsStatus(id1, status, id);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateList(String id, int status) {}
  static logout(BuildContext context) async {
    SharedPreferences a = await SharedPreferences.getInstance();
    a.getKeys();
    a.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ));
  }

  static Future cleardata(BuildContext context) async {
    SharedPreferences a = await SharedPreferences.getInstance();
    a.getKeys();
    a.clear();
  }

  static Future<void> updatepatientprofile() async {
    try {
      var query = "SELECT * FROM PatientModel where id='${patientmodel!.id}'";
      await SQLQuery.getdata(query).then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = await PatientModel.fromMap(value[0]);
          
           var query =
          "SELECT * FROM VisterUser where doctorid='${model.id}' OR patientid='${model.id}'"; List<VisterUser> listofuser=[];
      await SQLQuery.getdata(query).then((value) async {
        print("snaaaaaap    ${value}");
       
         List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        listofuser.add(VisterUser.fromMap(element));
      }
      });
        if (listofuser.isNotEmpty) {
        print("shjs");
    if (model != null) {
      model.doctorList ??= [];
      model.doctorList!.addAll(listofuser);
    } else {
      print("users is null");
    }
 
      print("shjsq11");
        
      }
     
          patientmodel = model;
          
        } catch (e) {
          return;
        }
      });
    } catch (e) {
      print("errrrrrrror    $e");
      Fluttertoast.showToast(
        msg: "${e.toString()} !",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static Future<void> updatedoctorprofile() async {
    try {
      var query = "SELECT * FROM DoctorModel where id='${doctorModel!.id}'";
      SQLQuery.getdata(query).then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = DoctorModel.fromMap(value[0]);
        
          
           var query =
          "SELECT * FROM VisterUser where doctorid='${model.id}' OR patientid='${model.id}'"; List<VisterUser> listofuser=[];
      await SQLQuery.getdata(query).then((value) async {
        print("snaaaaaap    ${value}");
       
         List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        listofuser.add(VisterUser.fromMap(element));
      }
      });
       if (listofuser.isNotEmpty) {
        print("shjs");
    if (model != null) {
      model.patientList ??= [];
      model.patientList!.addAll(listofuser);
    } else {
      print("users is null");
    }
 
      print("shjsq11");
        
      }
       doctorModel = model;
        } catch (e) {
          return;
        }
      });
    } catch (e) {
      print("errrrrrrror    $e");
      Fluttertoast.showToast(
        msg: "${e.toString()} !",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static String formatMicrosecondsSinceEpoch(int microsecondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);

    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);

    return formattedDate;
  }

  static String chatRoomId(String user1, String user2) {
    if (user1.compareTo(user2) < 0) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  static openWhatsAppChat() async {
    try {
      String url = "https://wa.me/+923073921189?text=Hello";

      await launch(url);
    } catch (e) {
      print("errorr${e}");
    }
  }

  static openEmailChat() async {
    try {
      String url = 'mailto:jamalihassan0307@gmail.com';

      await launch(url);
    } catch (e) {
      print("errorr${e}");
    }
  }

  static TimeOfDay roundToNearestHalfHour(TimeOfDay timeOfDay) {
    int roundedHour = timeOfDay.hour;
    int roundedMinute = (timeOfDay.minute / 30).round() * 30;

    if (roundedMinute == 60) {
      roundedMinute = 0;
      roundedHour++;
    }

    return TimeOfDay(hour: roundedHour, minute: roundedMinute);
  }
}

double kDefaultPadding = 16.0;
const kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

const kSubtitleTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 16,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);
