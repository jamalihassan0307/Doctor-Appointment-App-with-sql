import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/screens/error_screen/connection_failed.dart';
import 'package:doctor_appointment_app/screens/welcome_screen.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/admin_nav_bar.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/widgets/navbar_roots.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SQL.connection();
    getDataFromSF();

    Get.put(LoginController());
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Apptheme.primary,
      body: Center(
        child: Container(
          height: height,
          width: width,
          child: Center(
              child: Image.asset("images/well.gif", color: Colors.white)),
        ),
      ),
    );
  }

  Future<bool?> getDataFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? v = prefs.getString("patient");
    String? v1 = prefs.getString("doctor");
    print("v:$v");
    print("v1:$v1");
    StaticData.patient = v ?? "";
    StaticData.doctor = v1 ?? "";
    if (v != null && v != "") {
      try {
        await fetchpatientByUUID(v, context);
        return true;
      } catch (e) {
        print("error");
      }
    }
    if (v1 != null && v1 != "") {
      try {
        await fetchdoctorByUUID(v1, context);
        return true;
      } catch (e) {
        print("error");
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (route) => true,
      );
      return false;
    }

    return null;
  }

  bool isLoggedIn = false;
  Future<void> fetchdoctorByUUID(String uuid, context) async {
    DoctorModel? users;
    var q = "SELECT * FROM DoctorModel where id='${uuid}'";
    print("get data");

    try {
      await SQLQuery.getForSignin(q).then((value) async {
        print("snaaaaaap    ${value}");

        print("get data$value");
        try {
          if (value ==
              "Error: java.sql.SQLException: Network error IOException: Connection timed out") {
            print("aaasdadddasdadad");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectionFailed(),
                ));
          }
          //  else if(value.isBlank){

          //   Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const WelcomeScreen(),
          //   ),
          //   (route) => true,
          // );
          //  }
          else {
            users = DoctorModel.fromMap(value[0]);
          }
        } catch (e) {
          print('Document with UUID $uuid does not exist.$e');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
            (route) => true,
          );

          return;
        }

        isLoggedIn = true;
        StaticData.doctor = users!.id;
        StaticData.doctorModel = users;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminNavBarRoots(),
          ),
          (route) => true,
        );
      });
      print("Current user: $users");
    } catch (e) {
      print('Document with UUID $uuid does not exist.$e');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (route) => true,
      );

      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchpatientByUUID(String uuid, context) async {
    PatientModel? users;
    var q = "SELECT * FROM PatientModel where id='${uuid}'";
    try {
      SQLQuery.getForSignin(q).then((value) async {
        print("snaaaaaap    ${value}");

        print("get data$value");
        try {
          if (value ==
              "Error: java.sql.SQLException: Network error IOException: Connection timed out") {
            print("aaasdadddasdadad");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectionFailed(),
                ));
          }
          //  else if(value.lenght==0){

          //   Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const WelcomeScreen(),
          //   ),
          //   (route) => true,
          // );
          //  }
          else {
            users = PatientModel.fromMap(value[0]);
            LoginController.to.getAllDoctor();
          }
        } catch (e) {
          print('Document with UUID $uuid does not exist.$e');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
            (route) => true,
          );

          return;
        }

        isLoggedIn = true;
        StaticData.patient = users!.id;
        StaticData.patientmodel = users;

        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarRoots(),
            ),
            (route) => true,
          );
        });

        print("Current user: $users");
      });
    } catch (e) {
      print('Document with UUID $uuid does not exist.');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (route) => true,
      );

      print('Error fetching user data: $e');
    }
  }
}
