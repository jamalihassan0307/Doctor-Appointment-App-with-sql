import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdminChatController extends GetxController {
  static AdminChatController get to => Get.find();
  List<PatientModel> patientList = [];
  List<List<Message?>?> messageList = [];
  bool loading = false;
  Future<void> getpatient() async {
    loading = true;
    update();
    patientList.clear();
    if (StaticData.doctorModel!.patientList!.isNotEmpty) {
      for (var element in StaticData.doctorModel!.patientList!) {
        await SQL
            .get("select * from dbo.PatientModel where id='${element}'")
            .then((value) {
          try {
            patientList.add(PatientModel.fromMap(value[0]));
          } catch (e) {}
        });
      }
      print("aaaaa${patientList}");
      print("aaaaa${patientList.length}");
      getpatientmessage();
      update();
    } else {}
  }

  Future<void> getpatientmessage() async {
    print("data");

    messageList.clear();
    if (patientList.isNotEmpty) {
      for (var index = 0; index < patientList.length; index++) {
        String name = StaticData.chatRoomId(
            patientList[index].id, StaticData.doctorModel!.id);

        String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
        print("data1${name}  sdsf${id1}");
        try {
          SQL.get("select * from dbo.${id1}").then((value) {
            try {
              List<Map<String, dynamic>> tempResult =
                  value.cast<Map<String, dynamic>>();
              List<Message> list = [];

              for (var e in tempResult) {
                list.add(Message.fromJson(e));
              }
              messageList.add(list);
              print("aadadadd${messageList}");
            } catch (e) {
              print("aaaaaaaaaaaaaaaaa0");
              // messageList[index]!.addAll([]);
              print("object");
            }
            update();
          }).catchError((error) {
            // update();
          });
        } catch (e) {
          messageList[index]!.addAll([]);
          // update();
        }
      }
      for (var ea in messageList) {
        ea!.sort(
          (a, b) => a!.sent!.compareTo(b!.sent!),
        );
      }
      print("messageList${messageList}");
      loading = false;
      update();
    } else {}
  }
  List<Message> read=[];
Future<void> getpatientmessageRead(bool readr) async {
  print("data");

  this.read.clear(); 
  if (patientList.isNotEmpty && patientList.length >= 2) {
    String query = '';
    String old = '';

    for (var index = 0; index < 2; index++) {
      String name = StaticData.chatRoomId(patientList[index].id, StaticData.doctorModel!.id);
      String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      print("data1$name  sdsf$id1");

      if (index == 0) {
        query += 'SELECT $id1.toId, $id1.msg, $id1.readn, $id1.fromId, $id1.sent FROM dbo.$id1 AS $id1';
      } else {
        query += ' INNER JOIN dbo.$id1 AS $id1';
        if (readr) 
          query += ' ON $id1.readn = \'\'';
        else
          query += ' ON $id1.readn != $old.readn';
      }
      old = id1;
    }

    query += ' WHERE ' + patientList.sublist(0, 2).map((patient) {
      String name = StaticData.chatRoomId(patient.id, StaticData.doctorModel!.id);
      String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      return readr ? '$id1.readn = \'\'' : '$id1.readn IS NOT NULL';
    }).join(' AND ');

    print("query45667567$query");
    try {
      await SQL.get(query).then((value) {
        try {
          List<Map<String, dynamic>> tempResult = value.cast<Map<String, dynamic>>();
          List<Message> list = [];

          for (var e in tempResult) {
            list.add(Message.fromJson(e));
          }
          this.read.addAll(list);
          print("aadadadd${this.read}");
        } catch (e) {
          print("Error while parsing the result: $e");
        }
        update();
      }).catchError((error) {
        print("Error while executing the query: $error");
      });
    } catch (e) {
      print("Exception: $e");
    }

    this.read.sort(
      (a, b) => a.sent!.compareTo(b.sent!),
    );

    print("read${this.read}");
    loading = false;
    update();
  } else {
    Fluttertoast.showToast(
      msg: "At least 2 users are required for joining!",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      fontSize: 17,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_LONG,
    );
    
    print("patientList does not have enough entries");
  }
}

}
