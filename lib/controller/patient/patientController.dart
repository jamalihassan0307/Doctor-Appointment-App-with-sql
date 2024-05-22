import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PatientController extends GetxController {
  static PatientController get to => Get.find();
  List<AppointmentModel> allAppointment = [];
  bool loading = false;
  List<AppointmentModel> requested = [];
  List<AppointmentModel> confirmed = [];
  List<AppointmentModel> cencal = [];
  seperatedata() {
    if (allAppointment.isNotEmpty) {
      requested.addAll(allAppointment.where((element) => element.status == 1));
      confirmed.addAll(allAppointment.where((element) => element.status == 2));
      cencal.addAll(allAppointment.where((element) => element.status == 0));
      update();
    }
  }

  getAllAppointment() {
    allAppointment.clear();
    requested.clear();
    confirmed.clear();
    cencal.clear();
    update();
    print("dadada");
    loading = true;
    SQL
        .get(
            "select * from dbo.AppointmentModel where patientid='${StaticData.patientmodel!.id}'")
        .then((value) {
          print("valueeeeeeeeeeeeeeee${value}");
      // List<Map<String, dynamic>> tempResult =
      //     value.cast<Map<String, dynamic>>();
      // for (var element in tempResult) {
      //   allAppointment.add(AppointmentModel.fromMap(element));
      // }
      // print("alldoctor${allAppointment}");
      // print("alldoctor${allAppointment.length}");
      // loading = false;
      // seperatedata();
      // update();
    });
  }

  Future<bool> updateRating(String id, double fullrating) async {
    try {
      String query = "UPDATE dbo.AppointmentModel SET ";
      query += "rating = $fullrating";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  DoctorModel? getdoctor;

  Future<DoctorModel?> getdoctorF(String id) async {
    try {
      var snapshot = await SQL
          .get("SELECT * FROM DoctorModel where id='${id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        try {
          getdoctor = await DoctorModel.fromMap(value[0]);
          print("get data ${getdoctor}");
          update();
          return await getdoctor;
        } catch (e) {
          print("not found");
          return getdoctor;
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
    return null;
  }

  Future<bool> updateDoctorRating(String id, double fullrating) async {
    try {
      String query = "UPDATE dbo.AppointmentModel SET ";
      query += "rating = $fullrating";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDoctortotalRating(
      String id, double fullrating, int total) async {
    try {
      String query = "UPDATE dbo.DoctorModel SET ";
      query += "totalrating = $fullrating";
      query += "ratingperson = $total";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      LoginController.to.getAllDoctor();
      getAllAppointment();
      return true;
    } catch (e) {
      return false;
    }
  }
}
