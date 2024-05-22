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
      await getdoctormessage();
      update();
    } else {}
  }

  List<List<Message?>?> messageList = [];

  Future<void> getdoctormessage() async {
    print("data56675");

    messageList.clear();
    if (doctorlist.isNotEmpty) {
      print("data22222");
      for (var index = 0; index < doctorlist.length; index++) {
        print("data3333");
        String name = StaticData.chatRoomId(
            doctorlist[index].id, StaticData.patientmodel!.id);

        String id1 = name.substring(0, 20).replaceAll(RegExp(r'[^a-zA-Z]'), '');
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
    } else {
      print("list is empty");
    }
  }
}
