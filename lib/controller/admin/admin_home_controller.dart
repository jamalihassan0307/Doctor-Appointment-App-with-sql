import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  static AdminHomeController get to => Get.find();







  
  int schedule = 0;
  Future<int> getSchedule() async {
    QuerySnapshot snapshot = await StaticData.firebase
        .collection("slots")
        .doc(StaticData.doctorModel!.id.toString())
        .collection("slots")
        .where("isAvailable", isEqualTo: true)
        .get();
    schedule = snapshot.docs.length;
    update();
    return schedule;
  }
}
