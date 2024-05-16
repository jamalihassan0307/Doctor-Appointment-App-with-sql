import 'package:doctor_appointment_app/screens/admin/admin_massage.dart';
import 'package:doctor_appointment_app/screens/admin/AdminHomeScreen.dart';
import 'package:doctor_appointment_app/screens/admin/admin_schedule.dart';
import 'package:doctor_appointment_app/screens/admin/admin_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminNavBarRoots extends StatefulWidget {
  const AdminNavBarRoots({Key? key}) : super(key: key);

  @override
  State<AdminNavBarRoots> createState() => _AdminNavBarRootsState();
}

class _AdminNavBarRootsState extends State<AdminNavBarRoots> {
  int _selectedIndex = 0;
  final _screen = [
    AdminHomeScreen(),
    AdminMessagesScreen(),
    AdminSchedule(),
    AdminSettingsScreen(),
  ];

  @override
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
