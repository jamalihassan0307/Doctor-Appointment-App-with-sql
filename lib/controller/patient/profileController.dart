// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/widgets/navbar_roots.dart';
// import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passToggle = false;
  String? image;
  File? file;
  String link = "";
  initalizedata() {
    name.text = StaticData.patientmodel!.fullname;
    email.text = StaticData.patientmodel!.email;
    password.text = StaticData.patientmodel!.password;
    image = StaticData.patientmodel!.image;
    update();
  }

  XFile? hpickedFile;

  pickImage(ImageSource source) async {
    var pickedImage = await ImagePicker().pickImage(source: source);
    update();
    if (pickedImage != null) {
      hpickedFile = pickedImage;
      update();
    }
    print("xfileimage$hpickedFile");
    return hpickedFile;
  }

  Future<void> updateprofile(BuildContext context) async {
    if (hpickedFile != null) {
      // Uint8List imageBytes = await hpickedFile!.readAsBytes();
      // String base64Image = base64Encode(imageBytes);

      String query = "UPDATE PatientModel SET ";
      query += "fullname = '${name.text}',";
      query += "email =' ${email.text}',";
      query += "password = '${password.text}',";
      query += "image = '${hpickedFile!.path}'";

      query += " WHERE id = '${StaticData.patientmodel!.id}'";
      if (StaticData.localdatabase) {
        var map = {
          'fullname': '${name.text}',
          'email': '${email.text}',
          'password': '${password.text}',
          'image': '${hpickedFile!.path}',
        };
        try {
          var result = await SQLService.updateData(
              'PatientModel', map, StaticData.patientmodel!.id);
          print("resultresult${result.toString()}");
        } catch (e) {
          print("Error in updateprofile: $e");
        }
      } else {
        try {
          var result = await SQL.Update(query);
          print("resultresult${result.toString()}");
        } catch (e) {
          print("Error in updateprofile: $e");
        }
      }

      Fluttertoast.showToast(
          msg: "Update Succssfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      StaticData.updatepatientprofile().then((value) {
        initalizedata();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarRoots(),
            ));
      });
    } else {
      String query = "UPDATE PatientModel SET ";
      query += "fullname = '${name.text}'";
      query += "email = '${email.text}'";
      query += "password = '${password.text}'";

      query += " WHERE id = '${StaticData.patientmodel!.id}'";
      if (StaticData.localdatabase) {
        try {
          var map = {
            'fullname': '${name.text}',
            'email': '${email.text}',
            'password': '${password.text}',

//  "email =' ${email.text}',",

//  "password = '${password.text}',",
//  "image = '${hpickedFile!.path}'",
          };
          var result = await SQLService.updateData(
              'PatientModel', map, StaticData.patientmodel!.id);
          print("resultresult${result.toString()}");
        } catch (e) {
          print("Error in updateprofile: $e");
        }
      } else {
        try {
          var result = await SQL.Update(query);
          print("resultresult${result.toString()}");
        } catch (e) {
          print("Error in updateprofile: $e");
        }
      }

      Fluttertoast.showToast(
          msg: "Update Succssfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      await StaticData.updatepatientprofile().then((value) {
        initalizedata();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarRoots(),
            ));
      });
    }
  }
}
