// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StaticData {
  static String image64 =
      "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";
  static String patient = "";
  static String doctor = "";
  static DoctorModel? doctorModel;
  static PatientModel? patientmodel;
  static String token = "";
  static http.Response? response;


  static FirebaseFirestore firebase = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<bool> updateSlotsStatus(
      String database, String id, int status) async {
    try {
      String id1 =database.substring(0, 10).replaceAll(RegExp(r'[^a-zA-Z]'), '');
      String query = "UPDATE dbo.${id1} SET ";
      query += "isAvailable = $status";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAppointmentStatus(String id, int status) async {
    try {
      String query = "UPDATE dbo.AppointmentModel SET ";
      query += "status = $status";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }

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

  // static updatetokken(String tokken, String id, String collectionname) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(
  //       collectionname == "PatientModel" ? "patient" : "doctor", id);
  //   String query =
  //       "UPDATE dbo.${collectionname == 'patient' ? "PatientModel" : 'DoctorModel'} SET ";
  //   query += "token = '${token}'";

  //   query += " WHERE id = '${id}'";
  //   SQL.Update(query);
  // }

  static Future<void> updatepatientprofile() async {
    try {
      await SQL
          .get("SELECT * FROM PatientModel where id='${patientmodel!.id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = await PatientModel.fromMap(value[0]);
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

  static Future<String> getdoctortokken(String id) async {
    try {
      var snapshot = SQL
          .get("SELECT * FROM DoctorModel where id='${id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = DoctorModel.fromMap(value[0]);
          doctorModel = model;
          return model.token;
        } catch (e) {
          return " ";
        }
      });
      return " ";
    } catch (e) {
      print("errrrrrrror    $e");
      return "";
    }
  }

  static Future<void> updatedoctorprofile() async {
    try {
      var snapshot = SQL
          .get("SELECT * FROM DoctorModel where id='${doctorModel!.id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = DoctorModel.fromMap(value[0]);
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

  static sendNotifcation(String title, String msg, String tokken) async {
    print("token$tokken");
    var body = {
      "registration_ids": [tokken],
      "notification": {
        "body": msg,
        "title": title,
        "android_channel_id": "pushnotificationapp",
        "sound": true,
        // "image_url": image,
      },
      "data": {
        "source": "chat",
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization':
          'key=AAAAWEMSdOo:APA91bH0q5ylewTPC05vGyz0EIvjh_LKjZqVKxhIMtN5GIezWv2O3Qi267p181gumdX_jBLSv-rxwOMrzNsjeXiUrQd2Zdp7X7wbgX2dnVwB0TyOMmeRoJyB63aGsvKJpmM3CIjez2Py'
    };
    response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers, body: jsonEncode(body));
    if (response!.statusCode == 200) {
      print(response!.body);
      print('data: ${response!}');
      print('data statusCode: ${response!.statusCode}');
    } else {
      print('data: ${response!}');
      print('data statusCode: ${response!.statusCode}');

      print("error");
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