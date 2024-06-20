// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorModel {
  String id;
  String fullname;
  String phonenumber;
  String email;
  String password;
  String? image;
  String bio;
  String specialty;
  String starttime;
  String endtime;
  String about;
  String address;
  int maxAppointmentDuration;
  double totalrating;
  int ratingperson;
  List<VisterUser>? patientList;
  double fee;
  DoctorModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.password,
    required this.image,
    required this.bio,
    required this.specialty,
    required this.starttime,
    required this.endtime,
    required this.about,
    required this.address,
    required this.maxAppointmentDuration,
    required this.totalrating,
    required this.ratingperson,
     this.patientList,
    required this.fee,
  });

  String toMap() {
    return "'$id','$fullname','$phonenumber','$email','$password','$image','$bio','$specialty','$starttime','$endtime','$about','$address',$maxAppointmentDuration,$totalrating,$ratingperson,'${json.encode(patientList)}',$fee";
  }

  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      id: map['id'],
      fullname: map['fullname'],
      phonenumber: map['phonenumber'],
      email: map['email'],
      password: map['password'],
      image: map['image'],
      bio: map['bio'],
      specialty: map['specialty'],
      starttime: map['starttime'],
      endtime: map['endtime'],
      about: map['about'],
      maxAppointmentDuration: map['maxAppointmentDuration'],
      address: map['address'],
      totalrating: double.tryParse(map['totalrating'].toString()) ?? 0.0,
      ratingperson: map['ratingperson'],
      fee: double.tryParse(map['fee'].toString()) ?? 0.0,
    );
  }

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, fullname: $fullname, phonenumber: $phonenumber, email: $email, password: $password, bio: $bio, specialty: $specialty, starttime: $starttime, endtime: $endtime, about: $about, address: $address, maxAppointmentDuration: $maxAppointmentDuration, totalrating: $totalrating, ratingperson: $ratingperson, patientList: $patientList, fee: $fee, image: $image)';
  }
}
class VisterUser {
  String id;
  String doctorid;
  String patientid;
  VisterUser({
    required this.id,
    required this.doctorid,
    required this.patientid,
  });
   String toMap() {
    return "'$id','$doctorid','$patientid'";
  }
   factory VisterUser.fromMap(map) {
    return VisterUser(
      id: map['id'],
      doctorid: map['doctorid'],
      patientid: map['patientid'],
    );
  }

  factory VisterUser.fromJson(String source) =>
      VisterUser.fromMap(json.decode(source) as Map<String, dynamic>);
 @override
  String toString() {
    return 'VisterUser(id: $id, doctorid: $doctorid, patientid: $patientid,)';
  }
}
