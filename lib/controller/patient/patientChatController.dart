import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/staticdata.dart';
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
        await SQL
            .get("select * from dbo.DoctorModel where id='${element}'")
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
Future<void> getpatientmessageRead(bool readr) async {
  print("data");

  this.read.clear(); 
   if (doctorlist.isNotEmpty) {
    var query = '';
    String old = '';

    for (var index = 0; index < doctorlist.length; index++) {
      
      String name = StaticData.chatRoomId(
          doctorlist[index].id, StaticData.patientmodel!.id);

      // Create a unique identifier by removing non-alphabetic characters
      String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      print("data1$name  sdsf$id1");

      if (index == 0) {
        query += 'SELECT $id1.toId, $id1.msg, $id1.readn, $id1.fromId, $id1.sent FROM dbo.$id1 ';
      } else {
        query += ' INNER JOIN dbo.$id1 ';  
        if (readr) 
        query += ' ON $id1.readn = \'\'';
        else
        query += ' ON $id1.readn !=$old.readn';
      }
      old=id1;
    }

    query += ' WHERE ' + doctorlist.map((patient) {
      String name = StaticData.chatRoomId(
          patient.id, StaticData.patientmodel!.id);
      String id1 = name.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      return readr ? '$id1.readn = \'\'': '$id1.readn IS NOT NULL';
    }).join(' AND ');
    print("sssssss${query.length}");
for (var i = 0; i < query.length; i += 1000) {
  if ((i + 1000) < query.length) {
    print("${query.substring(i, i + 1000)}");
  } else {
    print("${query.substring(i, query.length)}");
  }
}

print("eeeeeee");
    // print("query45667567 ${query.substring(0,1000)}");
    // print("query45667567 ${query.substring(1000,1367)}");
    try {
      await SQL.get(query).then((value) {
        try {
          List<Map<String, dynamic>> tempResult =
              value.cast<Map<String, dynamic>>();
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
    print("patientList is empty");
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
  //         SQL.get("select * from dbo.${id1}").then((value) {
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
