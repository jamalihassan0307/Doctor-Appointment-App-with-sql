import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/adminHome.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
      await uploadImage(StaticData.doctorModel!.id.toString()).then((value) {

  StaticData.firebase
              .collection("doctor")
              .doc(StaticData.doctorModel!.id.toString())
              .update({
            "fullname": name.text,
            "email": email.text,
            "phonenumber": phonenumber.text,
            "address": address.text,
            "specialty": specilest.text,
            "bio": bio.text,
            "fee": double.tryParse(fee.text) ?? 0.0,
            "about": about.text,
            "starttime": startTime,
            "endtime": endTime,
            "maxAppointmentDuration": maxAppointmentDuration,
            "password": password.text,
            "image": value
          });

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
          Future.delayed( Duration(seconds: 2),(){
 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminNavBarRoots(),
              ));
          });
        });
        
      });
    } else {
      StaticData.firebase
          .collection("doctor")
          .doc(StaticData.doctorModel!.id.toString())
          .update({
        "fullname": name.text,
        "email": email.text,
        "phonenumber": phonenumber.text,
        "address": address.text,
        "specialty": specilest.text,
        "bio": bio.text,
        "about": about.text,
        "starttime": startTime,
        "fee": double.tryParse(fee.text) ?? 0.0,
        "endtime": endTime,
        "maxAppointmentDuration": maxAppointmentDuration,
        "password": password.text,
         "image": StaticData.doctorModel!.image,
      });
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
          Future.delayed( Duration(seconds: 2),(){
 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminNavBarRoots(),
              ));
          });
        });

      
    }
  }

  Future<String> uploadImage(String id) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child("doctor").child(id);

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(
            await hpickedFile!.readAsBytes(),
            SettableMetadata(
              contentType: 'image/jpeg',
            ));
      } else {
        uploadTask = ref.putData(
          await hpickedFile!.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      if (taskSnapshot.state == TaskState.success) {
        var url = await ref.getDownloadURL();
        print("3333333333333/link$url");
        link = url;
      } else {
        Fluttertoast.showToast(
          msg: "Image upload failed!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 17,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (e) {
      print("error/${e.toString()}");
      Fluttertoast.showToast(
        msg: "Image upload error: /e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return link;
  }

  Future<void> changeEmailAndPassword(
      String newEmail, String newPassword) async {
    try {
      User? user = StaticData.auth.currentUser;

      if (user != null) {
        await user.updateEmail(newEmail);
        print("Email updated successfully to $newEmail");

        await user.updatePassword(newPassword);
        print("Password updated successfully");
      } else {
        print("User not signed in.");
      }
    } catch (error) {
      print("Error updating email and password: $error");
    }
  }
}
