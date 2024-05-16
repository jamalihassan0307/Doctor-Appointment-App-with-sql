// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DoctorSlot {
  String id;
  int? indexn;
  String? patientid;
  String doctorname;
  String doctorid;

  String startTime;
  String endTime;
  String? patientName;
  bool isAvailable;
  String date;
  DoctorSlot({
    required this.id,
    this.indexn,
    this.patientid,
    required this.doctorname,
    required this.doctorid,
    required this.startTime,
    required this.endTime,
    this.patientName,
    required this.isAvailable,
    required this.date,
  });

  DoctorSlot copyWith({
    String? id,
    int? indexn,
    String? patientid,
    String? doctorname,
    String? doctorid,
    String? startTime,
    String? endTime,
    String? patientName,
    bool? isAvailable,
    String? date,
  }) {
    return DoctorSlot(
      id: id ?? this.id,
      indexn: indexn ?? this.indexn,
      patientid: patientid ?? this.patientid,
      doctorname: doctorname ?? this.doctorname,
      doctorid: doctorid ?? this.doctorid,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      patientName: patientName ?? this.patientName,
      isAvailable: isAvailable ?? this.isAvailable,
      date: date ?? this.date,
    );
  }

  String toMap() {
    return "'$id',$indexn,'$patientid','$doctorname','$doctorid','$startTime','$endTime','$patientName',${isAvailable ? 1 : 0},'$date'";
  }

  factory DoctorSlot.fromMap(map) {
    return DoctorSlot(
      id: map['id'],
      indexn: map['indexn'] ?? 0,
      patientid: map['patientid'],
      doctorname: map['doctorname'],
      doctorid: map['doctorid'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      patientName: map['patientName'] == null ? "" : map['patientName'],
      isAvailable: (map['isAvailable']) == 1 ? true : false,
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorSlot.fromJson(String source) =>
      DoctorSlot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorSlot(id: $id, indexn: $indexn, patientid: $patientid, doctorname: $doctorname, doctorid: $doctorid, startTime: $startTime, endTime: $endTime, patientName: $patientName, isAvailable: $isAvailable, date: $date)';
  }

  @override
  bool operator ==(covariant DoctorSlot other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.indexn == indexn &&
        other.patientid == patientid &&
        other.doctorname == doctorname &&
        other.doctorid == doctorid &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.patientName == patientName &&
        other.isAvailable == isAvailable &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        indexn.hashCode ^
        patientid.hashCode ^
        doctorname.hashCode ^
        doctorid.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        patientName.hashCode ^
        isAvailable.hashCode ^
        date.hashCode;
  }
}
