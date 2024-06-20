// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';

// import 'package:flutter/foundation.dart';

class PatientModel {
  String id;
  String fullname;
  String phonenumber;
  String password;
  String email;
  String image;
  List<VisterUser>? doctorList=[];

  PatientModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.password,
    required this.email,
    
    required this.image,
     this.doctorList,
  });
 
  
  String toMap() {
    return "'$id','$fullname','$phonenumber','$password','$email','$image'";
  }

  factory PatientModel.fromMap(map) {
    return PatientModel(
      id: map['id'],
      fullname: map['fullname'],
      phonenumber: map['phonenumber'],
      password: map['password'],
      email: map['email'],
      image: map['image'],
    );
  }

  

  @override
  String toString() {
    return 'PatientModel(id: $id, fullname: $fullname, phonenumber: $phonenumber, password: $password, email: $email, doctorList: $doctorList, image: $image)';
  }

  
}
