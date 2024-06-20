import 'package:doctor_appointment_app/SQL/Sql_query.dart';
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
        var query = "select * from PatientModel where id='${element.doctorid}'";
        await SQLQuery.getdata(query).then((value) {
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
          SQLQuery.getpatientmessage(id1).then((value) {
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

  List<Message> read = [];
  bool joining = false;
  bool sms = false;
  var selectedJoinType = '';
  void selectJoinType(String joinType) {
    selectedJoinType = joinType;
    if (joining) {
      getpatientmessageRead();
    }
  }

  updatejoining() {
    sms = false;
    joining = !joining;
    update();
  }

  List<PatientModel> patientListjoining = [];
  List<Message> list = [];
  Future<void> getpatientmessageRead() async {
    print("Starting getpatientmessageRead");

    this.read.clear();

    if (patientListjoining.isNotEmpty && patientListjoining.length >= 2) {
      String id1 = StaticData.chatRoomId(
              patientListjoining[0].id, StaticData.doctorModel!.id)
          .replaceAll(RegExp(r'[^a-zA-Z]'), '');
      String id2 = StaticData.chatRoomId(
              patientListjoining[1].id, StaticData.doctorModel!.id)
          .replaceAll(RegExp(r'[^a-zA-Z]'), '');

      try {
        var result =
            await SQLQuery.getpatientmessageRead(id1, selectedJoinType, id2);

        try {
          List<Map<String, dynamic>> tempResult =
              result.cast<Map<String, dynamic>>();
          List<Message> list = [];

          for (var e in tempResult) {
            // Exclude records where `toId` is null
            if (e['toId'] != null) {
              list.add(Message.fromJson(e));
            }
          }

          this.read.addAll(list);
          print("Messages retrieved: ${this.read.length}");
        } catch (e) {
          print("Error while parsing the result: $e");
        }

        sms = true;
        update();
      } catch (e) {
        print("Exception: $e");
      }

      this.read.sort((a, b) => a.sent!.compareTo(b.sent!));
      print("Sorted messages: ${this.read.length}");
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
      print("Not enough entries in patientListjoining");
    }
  }
}
