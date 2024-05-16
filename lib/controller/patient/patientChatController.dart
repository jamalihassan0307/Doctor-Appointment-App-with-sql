import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:get/get.dart';

class PatientChatController extends GetxController {
  static PatientChatController get to => Get.find();
  List<DoctorModel> doctorlist = [];
  Future<void> getdoctor() async {
    doctorlist = [];
    for (var e in StaticData.patientmodel!.doctorList) {
      DocumentSnapshot snapshot =
          await StaticData.firebase.collection("doctor").doc(e).get();
      DoctorModel model =
          DoctorModel.fromMap(snapshot.data() as Map<String, dynamic>);
      doctorlist.add(model);
    }
    update();
  }
}
