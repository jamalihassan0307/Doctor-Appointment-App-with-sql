import 'dart:io';

import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/widgets/navbar_roots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
      await uploadImage(StaticData.patientmodel!.id.toString()).then((value) {
          StaticData.firebase
              .collection("patient")
              .doc(StaticData.patientmodel!.id.toString())
              .update({
            "fullname": name.text,
            "email": email.text,
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
 StaticData.updatepatientprofile().then((value) {
            initalizedata();
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBarRoots(),
              ));
          
          });
          

       
      });
    } else {
      StaticData.firebase
            .collection("patient")
            .doc(StaticData.patientmodel!.id.toString())
            .update({
          "fullname": name.text,
          "email": email.text,
          "password": password.text,
           "image": StaticData.patientmodel!.image,
        });
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
         
     
    }
  }

  Future<String> uploadImage(String id) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child("patient").child(id);

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
        print("3333333333333/link");
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
