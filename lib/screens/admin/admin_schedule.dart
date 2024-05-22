import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_canceled_schedule.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_completed_schedule.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_upcoming_schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSchedule extends StatefulWidget {
  @override
  State<AdminSchedule> createState() => _AdminScheduleState();
}

class _AdminScheduleState extends State<AdminSchedule> {
  int _buttonIndex = 0;
  final _scheduleWidgets = [
    AdminUpcomingSchedule(),
    AdminCompletedSchedule(),
    AdminCanceledSchedule(),
  ];

  @override
  void initState() {
    Get.put(AdminHomeController());
    AdminHomeController.to.getAllAppointment();

    super.initState();
  }

  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(builder: (obj) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Schedule",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _buttonIndex = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 22),
                              decoration: BoxDecoration(
                                color: _buttonIndex == 0
                                    ? Color(0xFF7165D6)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Request",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _buttonIndex == 0
                                      ? Colors.white
                                      : Colors.black38,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _buttonIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 22),
                              decoration: BoxDecoration(
                                color: _buttonIndex == 1
                                    ? Color(0xFF7165D6)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _buttonIndex == 1
                                      ? Colors.white
                                      : Colors.black38,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _buttonIndex = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 22),
                              decoration: BoxDecoration(
                                color: _buttonIndex == 2
                                    ? Color(0xFF7165D6)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Canceled",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _buttonIndex == 2
                                      ? Colors.white
                                      : Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _scheduleWidgets[_buttonIndex],
                  ],
                ),
              ),
            ),
          ),
          if (obj.loadingapp == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      );
    });
  }
}
