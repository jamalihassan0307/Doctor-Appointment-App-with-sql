import 'package:doctor_appointment_app/SQL/sql.dart';
import 'package:doctor_appointment_app/screens/massage/notification_service.dart';
import 'package:doctor_appointment_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
import 'package:doctor_appointment_app/screens/admin/adminHome.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/widgets/navbar_roots.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    getToken();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          print(message);
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("123231${message.data}");
        if (message.notification != null) {
          LocalNotificationService.createAndDisplayChatNotification(message);
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print('app open on click');
        print(message.notification!.body);
        print(message.notification!.title);
        print(message.data);

        if (message.notification != null) {}
      },
    );
  }

  late FirebaseMessaging messaging;

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                bottom: 680,
                child: Text(
                  "We Make Easy to Appointment",
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 43, 56),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(child: Image(image: AssetImage("images/splash.gif"))),
            ],
          ),
        ),
      ),
    );
  }

  getToken() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      if (value != null) {
        StaticData.token = value;
      }

      print(value);
    });
  }

  Future<bool?> getDataFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? v = prefs.getString("patient");
    String? v1 = prefs.getString("doctor");
    print("v:$v");
    print("v1:$v1");
    getToken();
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
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
          (route) => true,
        );
      });
      return false;
    }

    return null;
  }

  bool isLoggedIn = false;
  Future<void> fetchdoctorByUUID(String uuid, context) async {
    DoctorModel? users;
    print("get data");
    try {
      var snapshot =
          await StaticData.firebase.collection("doctor").doc(uuid).get();
      if (snapshot.exists) {
        print("get data");
        users = DoctorModel.fromMap(snapshot.data()!);
        isLoggedIn = true;
        StaticData.doctor = users.id;
        StaticData.doctorModel = users;

        StaticData.updatetokken(
            StaticData.token, users.id.toString(), "doctor");
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminNavBarRoots(),
            ),
            (route) => true,
          );
        });

        print("Current user: $users");
      } else {
        print('Document with UUID $uuid does not exist.');
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
            (route) => true,
          );
        });
      }
    } catch (e) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
          (route) => true,
        );
      });

      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchpatientByUUID(String uuid, context) async {
    PatientModel? users;
    try {
      var snapshot =
          await StaticData.firebase.collection("patient").doc(uuid).get();
      if (snapshot.exists) {
        users = PatientModel.fromMap(snapshot.data()!);
        isLoggedIn = true;
        StaticData.patient = users.id;
        StaticData.patientmodel = users;

        StaticData.updatetokken(
            StaticData.token, users.id.toString(), "patient");
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
      } else {
        print('Document with UUID $uuid does not exist.');
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
            (route) => true,
          );
        });
      }
    } catch (e) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
          (route) => true,
        );
      });

      print('Error fetching user data: $e');
    }
  }
}
