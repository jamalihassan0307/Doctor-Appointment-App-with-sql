// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:flutter/foundation.dart';

class PatientModel {
  String id;
  String fullname;
  String phonenumber;
  String password;
  String email;
  String token;
  String image;
  bool audiocallStatus;
  bool callStatus;
  String? type;
  String status;
  String? roomId;
  List<String> doctorList;

  PatientModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.password,
    required this.email,
    required this.token,
    required this.image,
    required this.audiocallStatus,
    required this.callStatus,
     this.type,
    required this.status,
     this.roomId,
    required this.doctorList,
  });

  
  String toMap() {
    return "'$id' ,'$fullname','$phonenumber','$password','$email','$token','$image',${audiocallStatus == true ? 1 : 0},${callStatus ? 1 : 0},'$type','$status','$roomId','${json.encode(doctorList)}'";
  }

  factory PatientModel.fromMap(map) {
    return PatientModel(
      id: map['id'],
      fullname: map['fullname'],
      phonenumber: map['phonenumber'],
      password: map['password'],
      email: map['email'],
      token: map['token'],
      image: map['image'],
      audiocallStatus: (map['audiocallStatus']) == 1 ? true : false,
      callStatus: (map['callStatus']) == 1 ? true : false,
      type: map['type']??null,
      status: map['status'],
      roomId: map['roomId']??null,
      doctorList: List<String>.from(json.decode(map['doctorList'])),
    );
  }

  

  @override
  String toString() {
    return 'PatientModel(id: $id, fullname: $fullname, phonenumber: $phonenumber, password: $password, email: $email, token: $token, audiocallStatus: $audiocallStatus, callStatus: $callStatus, type: $type, status: $status, roomId: $roomId, doctorList: $doctorList, image: $image)';
  }

  
}
