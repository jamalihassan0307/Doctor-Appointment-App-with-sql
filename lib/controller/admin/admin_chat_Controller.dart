import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:get/get.dart';

class AdminChatController extends GetxController {
  static AdminChatController get to => Get.find();
  List<PatientModel> patientList = [];
  Future<void> getpatient() async {
    patientList = [];
    for (var e in StaticData.doctorModel!.patientList!) {
      DocumentSnapshot snapshot =
          await StaticData.firebase.collection("patient").doc(e).get();
      PatientModel model =
          PatientModel.fromMap(snapshot.data() as Map<String, dynamic>);
      patientList.add(model);
    }
    update();
  }
}
