import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:get/get.dart';

import '../../SQL/sql.dart';

class AdminHomeController extends GetxController {
  static AdminHomeController get to => Get.find();

  List<AppointmentModel> allAppointment = [];
  bool loadingapp = false;
  List<AppointmentModel> requested = [];
  List<AppointmentModel> confirmed = [];
  List<AppointmentModel> cencal = [];

   Future<bool> updateSlotsStatus(
      String database, String id, int status) async {
    try {
      String id1 =database.substring(0, 10).replaceAll(RegExp(r'[^a-zA-Z]'), '');
      String query = "UPDATE dbo.${id1} SET ";
      query += "isAvailable = $status";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }
  updateList(String id,int status,AppointmentModel model){
if (requested.any((element) => element.id==id)) {
  requested.removeWhere((element) =>  element.id==id);
} else if(confirmed.any((element) => element.id==id)){
   confirmed.removeWhere((element) =>  element.id==id);
}else if(cencal.any((element) => element.id==id)){
 cencal.removeWhere((element) =>  element.id==id);
}else{
  print("skip");
}
if (status==1) {
  model.status=1;
  requested.add(model);
} else if(status==2){
   model.status=1;
  confirmed.add(model);
}else if(status==0){ 
 model.status=1;
  cencal.add(model);
}else{
print("skip21");
}
update(["AppointmentModel"]);
  }

   Future<bool> updateAppointmentStatus(String id, int status) async {
    
    
    
    try {
      String query = "UPDATE dbo.AppointmentModel SET ";
      query += "status = $status";

      query += " WHERE id = '${id}'";
      SQL.Update(query);
      return true;
    } catch (e) {
      return false;
    }
  }


  seperatedata() {
    if (allAppointment.isNotEmpty) {
      requested.addAll(allAppointment.where((element) => element.status == 1));
      confirmed.addAll(allAppointment.where((element) => element.status == 2));
      cencal.addAll(allAppointment.where((element) => element.status == 0));
      update();
    }
  }

  String? patienttokken;
  Future<String> getpatienttokken(String id) async {
    try {
      await SQL
          .get("SELECT * FROM PatientModel where id='${id}'")
          .then((value) async {
        print("snaaaaaap    ${value}");

        print("get data");
        try {
          var model = PatientModel.fromMap(value[0]);
          patienttokken = model.token;
          return model.token;
        } catch (e) {
          return " ";
        }
      });
      return " ";
    } catch (e) {
      print("errrrrrrror    $e");
      return "";
    }
  }

  getAllAppointment() {
    allAppointment.clear();
    requested.clear();
    confirmed.clear();
    cencal.clear();
    update();
    print("dadada");
    loadingapp = true;
    try {
        SQL
        .get(
            "select * from dbo.AppointmentModel where doctorid='${StaticData.doctorModel!.id}'")
        .then((value) {
          print("aefwserftetwerta${value}");
      List<Map<String, dynamic>> tempResult =
          value.cast<Map<String, dynamic>>();
      for (var element in tempResult) {
        try {
           allAppointment.add(AppointmentModel.fromMap(element));
        } catch (e) {
          print("werwer1234$e");
        }
       
      }
      print("allAppointment${allAppointment}");
      print("allAppointment${allAppointment.length}");
      loadingapp = false;
      seperatedata();
      update();
    });
    } catch (e) {
      print("werwer$e");
    }
  
  }

  List<PatientModel> allPatients = [];
  bool loading = false;
  getAllPatient() {
    loading = true;
    allPatients.clear();
    if (StaticData.doctorModel!.patientList!.isNotEmpty) {
      for (var element in StaticData.doctorModel!.patientList!) {
        SQL
            .get("select * from dbo.PatientModel where id='${element}'")
            .then((value) {
              print("value$value");
          try {
            allPatients.add(PatientModel.fromMap(value[0]));
          } catch (e) {
            print("errrrr${e}");
          }
          update();
        });
      }
      loading = false;
      update();
    } else {}
  }

  String? schedule = '0';
  Future<String?> getSchedule() async {
    String id1 = StaticData.doctorModel!.id
        .substring(0, 10)
        .replaceAll(RegExp(r'[^a-zA-Z]'), '');
    SQL
        .get(
            "select count(isAvailable) as data from dbo.${id1} where isAvailable=1")
        .then((value) {
      try {
        if (value != "" && value != null) {
          schedule = value[0]["data"].toString();
          print("qwer${schedule}");
          update();
        }
      } catch (e) {
        print("EEEEEEEE${e}");
      }
    });

    return schedule;
  }
}
