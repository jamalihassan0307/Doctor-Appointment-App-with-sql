// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppointmentModel {
  String id;
  String patientid;
  String doctorid;
  String doctername;
  String docImage;
  String patientname;
  String patientimage;
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
    required this.doctername,
    required this.docImage,
    required this.patientname,
    required this.patientimage,
    required this.slotsid,
    required this.time,
    required this.createdtime,
    required this.status,
    required this.bio,
    this.rating,
  });

  AppointmentModel copyWith({
    String? id,
    String? patientid,
    String? doctorid,
    String? doctername,
    String? docImage,
    String? patientname,
    String? patientimage,
    String? slotsid,
    String? time,
    int? createdtime,
    int? status,
    String? bio,
    double? rating,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientid: patientid ?? this.patientid,
      doctorid: doctorid ?? this.doctorid,
      doctername: doctername ?? this.doctername,
      docImage: docImage ?? this.docImage,
      patientname: patientname ?? this.patientname,
      patientimage: patientimage ?? this.patientimage,
      slotsid: slotsid ?? this.slotsid,
      time: time ?? this.time,
      createdtime: createdtime ?? this.createdtime,
      status: status ?? this.status,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'patientid': patientid,
      'doctorid': doctorid,
      'doctername': doctername,
      'docImage': docImage,
      'patientname': patientname,
      'patientimage': patientimage,
      'slotsid': slotsid,
      'time': time,
      'createdtime': createdtime,
      'status': status,
      'bio': bio,
      'rating': rating,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      patientid: map['patientid'],
      doctorid: map['doctorid'],
      doctername: map['doctername'],
      docImage: map['docImage'],
      patientname: map['patientname'],
      patientimage: map['patientimage'],
      slotsid: map['slotsid'],
      time: map['time'],
      createdtime: map['createdtime'],
      status: map['status'],
      bio: map['bio'],
      rating: map['rating'] != null ? map['rating'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppointmentModel(id: $id, patientid: $patientid, doctorid: $doctorid, doctername: $doctername, docImage: $docImage, patientname: $patientname, patientimage: $patientimage, slotsid: $slotsid, time: $time, createdtime: $createdtime, status: $status, bio: $bio, rating: $rating)';
  }

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.patientid == patientid &&
        other.doctorid == doctorid &&
        other.doctername == doctername &&
        other.docImage == docImage &&
        other.patientname == patientname &&
        other.patientimage == patientimage &&
        other.slotsid == slotsid &&
        other.time == time &&
        other.createdtime == createdtime &&
        other.status == status &&
        other.bio == bio &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        patientid.hashCode ^
        doctorid.hashCode ^
        doctername.hashCode ^
        docImage.hashCode ^
        patientname.hashCode ^
        patientimage.hashCode ^
        slotsid.hashCode ^
        time.hashCode ^
        createdtime.hashCode ^
        status.hashCode ^
        bio.hashCode ^
        rating.hashCode;
  }
}
