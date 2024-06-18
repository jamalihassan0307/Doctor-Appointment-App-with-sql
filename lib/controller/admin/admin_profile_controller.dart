// import 'dart:convert';

import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/admin_nav_bar.dart';
import 'package:doctor_appointment_app/staticdata.dart';
// import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfileController extends GetxController {
  static AdminProfileController get to => Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController specilest = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController password = TextEditingController();
  String patientimage = '';
  TextEditingController patientname = TextEditingController();
  TextEditingController patientemail = TextEditingController();
  TextEditingController patientphonenumber = TextEditingController();
  TextEditingController fee = TextEditingController();

  patientDprofile(PatientModel model) {
    patientimage = model.image;
    patientname.text = model.fullname;
    patientemail.text = model.email;
    patientphonenumber.text = model.phonenumber;
    update();
  }

  clearprofile() {
    patientemail.clear();
    patientname.clear();
    patientphonenumber.clear();
    patientimage = "";
    update();
  }

  initalizedata() {
    name.text = StaticData.doctorModel!.fullname;
    email.text = StaticData.doctorModel!.email;
    password.text = StaticData.doctorModel!.password;
    image = StaticData.doctorModel!.image;
    phonenumber.text = StaticData.doctorModel!.phonenumber;
    address.text = StaticData.doctorModel!.address;
    specilest.text = StaticData.doctorModel!.specialty;
    bio.text = StaticData.doctorModel!.bio;
    about.text = StaticData.doctorModel!.about;
    startTime = StaticData.doctorModel!.starttime;
    endTime = StaticData.doctorModel!.endtime;
    fee.text = StaticData.doctorModel!.fee.toString();
    maxAppointmentDuration = StaticData.doctorModel!.maxAppointmentDuration;
    update();
  }

  bool passToggle = false;
  String? image;
  String link = "";
  String? startTime;
  String? endTime;
  int? maxAppointmentDuration;

  int? index = 1;
  int? duration;
  List<String> time = ["10", "20", "30"];
  updateduration(int a) {
    duration = a;
    maxAppointmentDuration = int.tryParse(time[a]);
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
    StaticData.updatedoctorprofile();
    if (hpickedFile != null) {
      // Uint8List imageBytes = await hpickedFile!.readAsBytes();
      // String base64Image = base64Encode(imageBytes);

      String query = "UPDATE DoctorModel SET ";
      query += "fullname = '${name.text}',";
      query += "email ='${email.text}',";
      query += "password = '${password.text}',";
      query += "address = '${address.text}',";
      query += "specialty = '${specilest.text}',";
      query += "bio = '${bio.text}',";
      query += "fee = '${double.tryParse(fee.text) ?? 0.0}',";
      query += "about = '${about.text}',";
      query += "starttime = '${startTime}',";
      query += "endtime = '${endTime}',";
      query += "maxAppointmentDuration = '${maxAppointmentDuration}',";

      query += "image = '${hpickedFile!.path}'";

      query += " WHERE id = '${StaticData.doctorModel!.id}'";
       if (StaticData.localdatabase) {
      try {
         var map = {
  'fullname': name.text,
  'email': email.text,
  'password': password.text,
  'address': address.text,
  'specialty': specilest.text,
  'bio': bio.text,
  'fee': double.tryParse(fee.text) ?? 0.0,
  'about': about.text,
  'starttime': startTime,
  'endtime': endTime,
  'maxAppointmentDuration': maxAppointmentDuration,
  'image': hpickedFile!.path,
};
    var result = await SQLService.updateData('DoctorModel', map, StaticData.doctorModel!.id);
    print("resultresult${result.toString()}");

  } catch (e) {
    print("Error in updateprofile: $e");
 
  }
       }else{
 try {
      
    var result = await   SQL.Update(query);
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
      StaticData.updatedoctorprofile().then((value) {
        initalizedata();
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminNavBarRoots(),
              ));
        });
      });
    } else {
      String query = "UPDATE DoctorModel SET ";
      query += "fullname = '${name.text}',";
      query += "email =' ${email.text}',";
      query += "password = '${password.text}',";
      query += "address = '${address.text}',";
      query += "specialty = '${specilest.text}',";
      query += "bio = '${bio.text}',";
      query += "fee = '${double.tryParse(fee.text) ?? 0.0}',";
      query += "about = '${about.text}',";
      query += "starttime = '${startTime}',";
      query += "endtime = '${endTime}',";
      query += "maxAppointmentDuration = '${maxAppointmentDuration}',";

      query += " WHERE id = '${StaticData.doctorModel!.id}'";
       if (StaticData.localdatabase) {
        var map = {
  'fullname': name.text,
  'email': email.text,
  'password': password.text,
  'address': address.text,
  'specialty': specilest.text,
  'bio': bio.text,
  'fee': double.tryParse(fee.text) ?? 0.0,
  'about': about.text,
  'starttime': startTime,
  'endtime': endTime,
  'maxAppointmentDuration': maxAppointmentDuration,
};
      try {
    var result = await SQLService.updateData('DoctorModel', map, StaticData.doctorModel!.id);
    print("resultresult${result.toString()}");

  } catch (e) {
    print("Error in updateprofile: $e");
 
  }
       }else{
 try {
      
    var result = await   SQL.Update(query);
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
      StaticData.updatedoctorprofile().then((value) {
        initalizedata();
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminNavBarRoots(),
              ));
        });
      });
    }
  }
}
