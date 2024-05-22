// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  String type;
  String status;
  String roomId;
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
    required this.type,
    required this.status,
    required this.roomId,
    required this.doctorList,
  });

  PatientModel copyWith({
    String? id,
    String? fullname,
    String? phonenumber,
    String? password,
    String? email,
    String? token,
    String? image,
    bool? audiocallStatus,
    bool? callStatus,
    String? type,
    String? status,
    String? roomId,
    List<String>? doctorList,
  }) {
    return PatientModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      phonenumber: phonenumber ?? this.phonenumber,
      password: password ?? this.password,
      email: email ?? this.email,
      token: token ?? this.token,
      image: image ?? this.image,
      audiocallStatus: audiocallStatus ?? this.audiocallStatus,
      callStatus: callStatus ?? this.callStatus,
      type: type ?? this.type,
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      doctorList: doctorList ?? this.doctorList,
    );
  }

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
      type: map['type'],
      status: map['status'],
      roomId: map['roomId'],
      doctorList: List<String>.from(json.decode(map['doctorList'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PatientModel(id: $id, fullname: $fullname, phonenumber: $phonenumber, password: $password, email: $email, token: $token, audiocallStatus: $audiocallStatus, callStatus: $callStatus, type: $type, status: $status, roomId: $roomId, doctorList: $doctorList, image: $image)';
  }

  @override
  bool operator ==(covariant PatientModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.phonenumber == phonenumber &&
        other.password == password &&
        other.email == email &&
        other.token == token &&
        other.image == image &&
        other.audiocallStatus == audiocallStatus &&
        other.callStatus == callStatus &&
        other.type == type &&
        other.status == status &&
        other.roomId == roomId &&
        listEquals(other.doctorList, doctorList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        phonenumber.hashCode ^
        password.hashCode ^
        email.hashCode ^
        token.hashCode ^
        image.hashCode ^
        audiocallStatus.hashCode ^
        callStatus.hashCode ^
        type.hashCode ^
        status.hashCode ^
        roomId.hashCode ^
        doctorList.hashCode;
  }
}
