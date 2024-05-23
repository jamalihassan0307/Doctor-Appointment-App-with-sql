import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/massage.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
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
    } else {}
  }
}
