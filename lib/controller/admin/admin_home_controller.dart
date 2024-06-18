import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/model/admin/AppointmentModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:get/get.dart';

// import '../../SQL/sql.dart';

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
     String id1 =database.replaceAll(RegExp(r'[^a-zA-Z]'), '');
      SQLQuery.updateSlotsStatus1(id1, status, id);
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

 var selectedJoinType="";
   List<AppointmentModel> list = [];
   List<Map<String, dynamic>> data=[];
   bool show =false;
   updateShow(){
    show=!show;
    update();
   }

    Future<void> selectJoinType(String queryType) async {
 
list.clear();
data=[];
  String doctorId = StaticData.doctorModel!.id;
selectedJoinType=queryType;
update();
  

  try {
    await SQLQuery.selectJoinType(queryType, doctorId) .then((value) {
      if (queryType=="GROUP BY"||queryType=="HAVING") {
          List<Map<String, dynamic>> tempResult = value.cast<Map<String, dynamic>>();
         data=tempResult;
         print("sdfhkdfhsfj   ${data}");
             update();
      } else { List<Map<String, dynamic>> tempResult = value.cast<Map<String, dynamic>>();
    list = tempResult.map((e) => AppointmentModel.fromMap(e)).toList();
        print("Query result: $list");
        update();
       
      }
     
      // Handle the result (update UI, etc.)
    
    }).catchError((error) {
      print("Error while executing the query: $error");
    });
  } catch (e) {
    print("Exception: $e");
  }
}

   Future<bool> updateAppointmentStatus(String id, int status) async {
    
    
    
    try {
    
      SQLQuery.updateAppointmentStatus(status, id);
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

 
  getAllAppointment() {
    allAppointment.clear();
    requested.clear();
    confirmed.clear();
    cencal.clear();
    update();
    print("dadada");
    loadingapp = true;
    try {
         var query="select * from AppointmentModel where doctorid='${StaticData.doctorModel!.id}'";
        SQLQuery.getdata(query)
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
           var query="select * from PatientModel where id='${element}'";
        SQLQuery
            .getdata(query)
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
        
        .replaceAll(RegExp(r'[^a-zA-Z]'), '');
           var query="select count(isAvailable) as data from ${id1} where isAvailable=1";
    SQLQuery.getdata(query)
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
