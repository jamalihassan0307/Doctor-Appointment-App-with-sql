// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorModel {
  String id;
  String fullname;
  String phonenumber;
  String email;
  String password;
  String token;
  String? image;
  bool audiocallStatus;
  bool callStatus;
  String? type;
  String status;
  String roomId;
  String bio;
  String specialty;
  String starttime;
  String endtime;
  String about;
  String address;
  int maxAppointmentDuration;
  double totalrating;
  int ratingperson;
  List<String>? patientList;
  double fee;
  DoctorModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.password,
    required this.token,
    required this.image,
    required this.audiocallStatus,
    required this.callStatus,
    required this.type,
    required this.status,
    required this.roomId,
    required this.bio,
    required this.specialty,
    required this.starttime,
    required this.endtime,
    required this.about,
    required this.address,
    required this.maxAppointmentDuration,
    required this.totalrating,
    required this.ratingperson,
    required this.patientList,
    required this.fee,
  });

  DoctorModel copyWith({
    String? id,
    String? fullname,
    String? phonenumber,
    String? email,
    String? password,
    String? token,
    String? image,
    bool? audiocallStatus,
    bool? callStatus,
    String? type,
    String? status,
    String? roomId,
    String? bio,
    String? specialty,
    String? starttime,
    String? endtime,
    String? about,
    String? address,
    int? maxAppointmentDuration,
    double? totalrating,
    int? ratingperson,
    List<String>? patientList,
    double? fee,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      phonenumber: phonenumber ?? this.phonenumber,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      image: image ?? this.image,
      audiocallStatus: audiocallStatus ?? this.audiocallStatus,
      callStatus: callStatus ?? this.callStatus,
      type: type ?? this.type,
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      bio: bio ?? this.bio,
      specialty: specialty ?? this.specialty,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      about: about ?? this.about,
      address: address ?? this.address,
      maxAppointmentDuration:
          maxAppointmentDuration ?? this.maxAppointmentDuration,
      totalrating: totalrating ?? this.totalrating,
      ratingperson: ratingperson ?? this.ratingperson,
      patientList: patientList ?? this.patientList,
      fee: fee ?? this.fee,
    );
  }

  String toMap() {
    return "'$id','$fullname','$phonenumber','$email','$password','$token','$image','${audiocallStatus == true ? 1 : 0}','${callStatus ? 1 : 0}','$type','$status', '$roomId','$bio','$specialty','$starttime','$endtime','$about','$address',$maxAppointmentDuration,$totalrating,$ratingperson,'${json.encode(patientList)}',$fee";
  }

  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      id: map['id'],
      fullname: map['fullname'],
      phonenumber: map['phonenumber'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
      image: map['image'],
      audiocallStatus: (map['audiocallStatus']) == 1 ? true : false,
      callStatus: (map['callStatus']) == 1 ? true : false,
      type: map['type'],
      status: map['status'],
      roomId: map['roomId'],
      bio: map['bio'],
      specialty: map['specialty'],
      starttime: map['starttime'],
      endtime: map['endtime'],
      about: map['about'],
      maxAppointmentDuration: map['maxAppointmentDuration'],
      address: map['address'],
      totalrating: double.tryParse(map['totalrating'].toString()) ?? 0.0,
      ratingperson: map['ratingperson'],
      patientList: List<String>.from(json.decode(map['patientList'] ?? [])),
      fee: double.tryParse(map['fee'].toString()) ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, fullname: $fullname, phonenumber: $phonenumber, email: $email, password: $password, token: $token, audiocallStatus: $audiocallStatus, callStatus: $callStatus, type: $type, status: $status, roomId: $roomId, bio: $bio, specialty: $specialty, starttime: $starttime, endtime: $endtime, about: $about, address: $address, maxAppointmentDuration: $maxAppointmentDuration, totalrating: $totalrating, ratingperson: $ratingperson, patientList: $patientList, fee: $fee, image: $image)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.phonenumber == phonenumber &&
        other.email == email &&
        other.password == password &&
        other.token == token &&
        other.image == image &&
        other.audiocallStatus == audiocallStatus &&
        other.callStatus == callStatus &&
        other.type == type &&
        other.status == status &&
        other.roomId == roomId &&
        other.bio == bio &&
        other.specialty == specialty &&
        other.starttime == starttime &&
        other.endtime == endtime &&
        other.about == about &&
        other.address == address &&
        other.maxAppointmentDuration == maxAppointmentDuration &&
        other.totalrating == totalrating &&
        other.ratingperson == ratingperson &&
        listEquals(other.patientList, patientList) &&
        other.fee == fee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        phonenumber.hashCode ^
        email.hashCode ^
        password.hashCode ^
        token.hashCode ^
        image.hashCode ^
        audiocallStatus.hashCode ^
        callStatus.hashCode ^
        type.hashCode ^
        status.hashCode ^
        roomId.hashCode ^
        bio.hashCode ^
        specialty.hashCode ^
        starttime.hashCode ^
        endtime.hashCode ^
        about.hashCode ^
        address.hashCode ^
        maxAppointmentDuration.hashCode ^
        totalrating.hashCode ^
        ratingperson.hashCode ^
        patientList.hashCode ^
        fee.hashCode;
  }
}
