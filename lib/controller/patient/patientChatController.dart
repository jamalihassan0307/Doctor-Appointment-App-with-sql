import 'package:doctor_appointment_app/SQL/Sql_query.dart';
// import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PatientChatController extends GetxController {
  static PatientChatController get to => Get.find();
  List<DoctorModel> doctorlist = [];
  bool loading = false;
  Future<void> getdoctor() async {
    loading = true;
    doctorlist.clear();
    if (StaticData.patientmodel!.doctorList.isNotEmpty) {
      for (var element in StaticData.patientmodel!.doctorList) {
           var query="select * from DoctorModel where id='${element}'";
        await SQLQuery
            .getdata(query)
            .then((value) {
          try {
            doctorlist.add(DoctorModel.fromMap(value[0]));
            print("add /////////////${doctorlist}");
          } catch (e) {}
          update();
        });
      }
      loading = false;
      // await getdoctormessage();
      update();
    } else {}
  }
 List<Message> read=[];
  bool joining=false;
  bool sms=false;
   var selectedJoinType ='';
   void selectJoinType(String joinType) {
    selectedJoinType = joinType;
    if (joining) {
      
    getpatientmessageRead();
    }else{
      print("false");
    }
  }
  updatejoining(){
    sms=false;
    joining=!joining;
    update();
  }
  List<DoctorModel> doctorlistjoining=[];
   List<Message> list = [];
Future<void> getpatientmessageRead() async {
  print("data");

  this.read.clear(); 
  if (doctorlistjoining.isNotEmpty && doctorlistjoining.length >= 2) {
 
    String id1 = StaticData.chatRoomId(doctorlistjoining[0].id, StaticData.patientmodel!.id).replaceAll(RegExp(r'[^a-zA-Z]'), '');
    String id2 = StaticData.chatRoomId(doctorlistjoining[1].id, StaticData.patientmodel!.id).replaceAll(RegExp(r'[^a-zA-Z]'), '');

   
    try {
      await SQLQuery.getdotormessageRead(id1, selectedJoinType, id2).then((value) {
        try {
          List<Map<String, dynamic>> tempResult = value.cast<Map<String, dynamic>>();
          List<Message> list = [];

          for (var e in tempResult) {
            // Exclude records where `toId` is null
            if (e['toId'] != null) {
              list.add(Message.fromJson(e));
            }
          }
          this.read.addAll(list);
          print("aadadadd${this.read}");
        } catch (e) {
          print("Error while parsing the result: $e");
        }
        sms = true;
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

  // List<List<Message?>?> messageList = [];

  // Future<void> getdoctormessage() async {
  //   print("data56675");

  //   messageList.clear();
  //   if (doctorlist.isNotEmpty) {
  //     print("data22222");
  //     for (var index = 0; index < doctorlist.length; index++) {
  //       print("data3333");
  //       String name = StaticData.chatRoomId(
  //           doctorlist[index].id, StaticData.patientmodel!.id);

  //       String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  //       print("data1${name}  sdsf${id1}");
  //       try {
  //         SQL.get("select * from ${id1}").then((value) {
  //           try {
  //             List<Map<String, dynamic>> tempResult =
  //                 value.cast<Map<String, dynamic>>();
  //             List<Message> list = [];

  //             for (var e in tempResult) {
  //               list.add(Message.fromJson(e));
  //             }
  //             messageList.add(list);
  //             print("aadadadd${messageList}");
  //           } catch (e) {
  //             print("aaaaaaaaaaaaaaaaa0");
  //             // messageList[index]!.addAll([]);
  //             print("object");
  //           }
  //           update();
  //         }).catchError((error) {
  //           // update();
  //         });
  //       } catch (e) {
  //         messageList[index]!.addAll([]);
  //         // update();
  //       }
  //     }
  //     for (var ea in messageList) {
  //       ea!.sort(
  //         (a, b) => a!.sent!.compareTo(b!.sent!),
  //       );
  //     }
  //     print("messageList${messageList}");
  //     loading = false;
  //     update();
  //   } else {
  //     print("list is empty");
  //   }
  // }
}
