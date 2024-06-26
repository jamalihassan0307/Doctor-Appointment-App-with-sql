// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

class AppointmentModel {
  String id;
  String patientid;
  String doctorid;
  String? doctorname;
  String? docimage;
  String? patientname;
  String? patientimage;
  String slotsid;
  String time;
  int createdtime;
  int status;
  String bio;
  double? rating;
  AppointmentModel({
    required this.id,
    required this.patientid,
    required this.doctorid,
     this.doctorname,
     this.docimage,
     this.patientname,
     this.patientimage,
    required this.slotsid,
    required this.time,
    required this.createdtime,
    required this.status,
    required this.bio,
    this.rating,
  });

  String toMap() {
    return "'$id','$patientid','$doctorid','$slotsid','$time',$createdtime,$status,'$bio',$rating";
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
        id: map['id'],
        patientid: map['patientid'],
        doctorid: map['doctorid'],
        slotsid: map['slotsid'],
        time: map['time'],
        createdtime: map['createdtime'],
        status: map['status'],
        bio: map['bio'],
        rating: double.tryParse(map['rating'] != null
            ? (map['rating'].toString())
            : 0.0.toString()));
  }

  String toString() {
    return 'AppointmentModel(id: $id, patientid: $patientid, doctorid: $doctorid, doctername: $doctorname, docimage: $docimage, patientname: $patientname, patientimage: $patientimage, slotsid: $slotsid, time: $time, createdtime: $createdtime, status: $status, bio: $bio, rating: $rating)';
  }
}
