import 'package:doctor_appointment_app/SQL/Sql_query.dart';
// import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PatientController extends GetxController {
  static PatientController get to => Get.find();
  List<AppointmentModel> allAppointment = [];
  bool loading = false;
  // bool mainloading = false;
  // updateloading(bool lo){
  //   mainloading=lo;
  //   // update();
  // }
  List<AppointmentModel> requested = [];
  List<AppointmentModel> confirmed = [];
  List<AppointmentModel> cencal = [];
  updateList(String id, int status, AppointmentModel model) {
    if (requested.any((element) => element.id == id)) {
      requested.removeWhere((element) => element.id == id);
    } else if (confirmed.any((element) => element.id == id)) {
      confirmed.removeWhere((element) => element.id == id);
    } else if (cencal.any((element) => element.id == id)) {
      cencal.removeWhere((element) => element.id == id);
    } else {
      print("skip");
    }
    if (status == 1) {
      model.status = 1;
      requested.add(model);
    } else if (status == 2) {
      model.status = 1;
      confirmed.add(model);
    } else if (status == 0) {
      model.status = 1;
      cencal.add(model);
    } else {
      print("skip21");
    }
    update();
  }

  seperatedata() {
    if (allAppointment.isNotEmpty) {
      requested.addAll(allAppointment.where((element) => element.status == 1));
      confirmed.addAll(allAppointment.where((element) => element.status == 2));
      cencal.addAll(allAppointment.where((element) => element.status == 0));
      update();
    }
  }

  var selectedJoinType = "";
  List<AppointmentModel> list = [];
  List<Map<String, dynamic>> data = [];
  bool show = false;
  updateShow() {
    show = !show;
    update();
  }

  Future<void> selectJoinType(String queryType) async {
    String patientId = StaticData.patientmodel!.id;
    selectedJoinType = queryType;
    list.clear();
    data = [];
    update();

    try {
      await SQLQuery.selectJoinTypePatient(queryType, patientId).then((value) {
        if (queryType == "GROUP BY" || queryType == "HAVING") {
          List<Map<String, dynamic>> tempResult =
              value.cast<Map<String, dynamic>>();
          data = tempResult;
          print("sdfhkdfhsfj   ${data}");
        } else {
          List<Map<String, dynamic>> tempResult =
              value.cast<Map<String, dynamic>>();
          list = tempResult.map((e) => AppointmentModel.fromMap(e)).toList();
          print("Query result: $list");
          update();
        }

        // Handle the result (update UI, etc.)
      }).catchError((error) {
        print("Error while executing the query: $error");
      });
    } catch (e) {
      print("Exception: $e");
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
    var query =
        "select * from AppointmentModel where patientid='${StaticData.patientmodel!.id}'";
    SQLQuery.getdata(query).then((value) {

      print("valueeeeeeeeeeeeeeee${value[0]}");
      List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        var model=AppointmentModel.fromMap(element);
        print("sfjdfnj${model}");
 var query =
        "select image, fullname from DoctorModel where id='${model.doctorid}'";
    SQLQuery.getdata(query).then((value){
      print("value$value");
      model.docimage=value[0]['image'];
      model.doctorname=value[0]['fullname'];
    });
 var query1 =
        "select image, fullname from PatientModel where id='${model.patientid}'";
    SQLQuery.getdata(query1).then((value){
       print("value$value");
      model.patientimage=value[0]['image'];
      model.patientname=value[0]['fullname'];
    });

        allAppointment.add(model);
      }
      print("alldoctor${allAppointment}");
      print("alldoctor${allAppointment.length}");
      loading = false;
      seperatedata();
      update();
    });
  }

  Future<bool> updateRating(String id, double fullrating) async {
    try {
      SQLQuery.updateRating(fullrating, id);
      return true;
    } catch (e) {
      return false;
    }
  }

  DoctorModel? getdoctor;

  Future<DoctorModel?> getdoctorF(String id) async {
    try {
      var query = "SELECT * FROM DoctorModel where id='${id}'";
      await SQLQuery.getdata(query).then((value) async {
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
      SQLQuery.updateRating(fullrating, id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDoctortotalRating(
      String id, double fullrating, int total) async {
    try {
      SQLQuery.updateDoctortotalRating(fullrating, id, total);
      LoginController.to.getAllDoctor();
      getAllAppointment();
      return true;
    } catch (e) {
      return false;
    }
  }
}
