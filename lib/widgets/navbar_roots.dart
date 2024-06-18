import 'package:doctor_appointment_app/controller/patient/patientChatController.dart';
import 'package:doctor_appointment_app/controller/patient/patientController.dart';
import 'package:doctor_appointment_app/screens/patient/home_screen.dart';
import 'package:doctor_appointment_app/screens/patient/messages_screen.dart';
import 'package:doctor_appointment_app/screens/patient/schedule_screen.dart';
import 'package:doctor_appointment_app/screens/patient/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({Key? key}) : super(key: key);

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  List<Widget> _screen = [
    HomeScreen(),
    MessagesScreen(),
    ScheduleScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    Get.put(PatientController());

    Get.put(PatientChatController());
    //  PatientController.to.updateloading(true);
    PatientController.to.getAllAppointment();
    PatientChatController.to.getdoctor();
    // PatientController.to.updateloading(false);
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screen[_selectedIndex],
        bottomNavigationBar: Container(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF7165D6),
            unselectedItemColor: Colors.black26,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_fill),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Schedule",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
