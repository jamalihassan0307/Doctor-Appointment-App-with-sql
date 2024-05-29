// ignore_for_file: unnecessary_null_comparison

import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/admin/DoctorSlot.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/admin_nav_bar.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/widgets/navbar_roots.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  String errorMessage = "";
  TextEditingController email = TextEditingController();
  int index = 0;
  updateindex(int a) {
    index = a;
    update();
  }

  PatientModel? getpatient;

  Future<PatientModel?> getPatientId(String id) async {
    try {
      await SQL
          .get("SELECT * FROM PatientModel where id='${id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          getpatient = await PatientModel.fromMap(value[0]);
          update();
          return getpatient;
        } catch (e) {
          return null;
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

  DoctorModel? getdoctor;
  Future<DoctorModel?> getDoctorId(String id) async {
    try {
      await SQL
          .get("SELECT * FROM DoctorModel where id='${id}'")
          .then((value) async {
        try {
          getdoctor = await DoctorModel.fromMap(value[0]);
          print("modelasdsdf${getdoctor}");
          update();
          return getdoctor;
        } catch (e) {
          return null;
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

  TextEditingController password = TextEditingController();
  bool passToggle = true;

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      await SQL
          .get(
              "SELECT * FROM DoctorModel where email='${email.text}' AND password='${password.text}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        DoctorModel model = DoctorModel.fromMap(value[0]);
        StaticData.doctorModel = model;
        StaticData.doctor = model.id;
        update();
        // String query = "UPDATE dbo.DoctorModel SET ";
        // query += "token = '${StaticData.token}', ";

        // query += " WHERE id = '${model.id}'";
        // SQL.Update(query);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminNavBarRoots(),
            ));
        Fluttertoast.showToast(
            msg: "Login Succesfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        StaticData.cleardata(context).then((value) {
          prefs.setString("doctor", model.id);
          clearForm();
        });
      });

      update();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "User Not Found !",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void signInWithEmailAndPassword1(BuildContext context) async {
    try {
      await SQL
          .get(
              "SELECT * FROM PatientModel where email='${email.text}' AND password='${password.text}'")
          .then((value) async {
        print("snaaaaaap    ${value}");
        PatientModel? model;
        try {
          model =await PatientModel.fromMap(value[0]);
          print("model doctor list${model.doctorList}");
          print("model doctor list${model.doctorList.length}");
        } catch (e) {
          print("lsdfgjd${e}");
          Fluttertoast.showToast(
              msg: "User Not Found !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        StaticData.patientmodel = model;
        StaticData.patient = model.id;
        update();
        // String query = "UPDATE dbo.PatientModel SET ";
        // query += "token = '${StaticData.token}', ";

        // query += " WHERE id = '${model.id}'";
        // SQL.Update(query);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarRoots(),
            ));
        Fluttertoast.showToast(
            msg: "Login Succesfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        StaticData.cleardata(context).then((value) {
          prefs.setString("patient", model!.id);
          // clearForm();
          getAllDoctor();
        });
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "User Not Found !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  List<DoctorModel> alldoctor = [];
  getAllDoctor() {
    SQL.get("select * from dbo.DoctorModel").then((value) {
      List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        alldoctor.add(DoctorModel.fromMap(element));
      }
      print("alldoctor${alldoctor}");
      print("alldoctor${alldoctor.length}");
      update();
    });
  }

  List<DoctorSlot> slotsList = [];
  getdoctorSlotes(String id) {
    slotsList.clear();
    String id1 = id.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    SQL.get("select * from dbo.${id1}").then((value) {
      List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        print("element[isAvailable]${element["isAvailable"]}");
        if (element["isAvailable"] == true) {
          slotsList.add(DoctorSlot.fromMap(element));
        } else {
          print("skip");
        }
      }
      slotsList.sort(
        (a, b) => a.indexn!.compareTo(b.indexn!),
      );
      print("slots.list${slotsList.length}");
      print("slots.list${slotsList}");
      update(["slots"]);
    });
  }

  clearForm() {
    email.clear();
    password.clear();
    update();
  }
}
