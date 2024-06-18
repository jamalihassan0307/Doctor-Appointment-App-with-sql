import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
import 'package:doctor_appointment_app/widgets/admin/adminShow.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_canceled_schedule.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_completed_schedule.dart';
import 'package:doctor_appointment_app/widgets/admin/admin_upcoming_schedule.dart';
import 'package:doctor_appointment_app/widgets/loading.dart';
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

    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
  
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              "Schedule",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(width: width * 0.04),
                        // Icon(Icons.refresh),
                        SizedBox(width: width * 0.04),
                         PopupMenuButton<String>(
  color: Colors.white,
  onSelected: (String result) {
    obj.selectJoinType(result);  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: 'WHERE',
      child: Text('WHERE'),
    ),
    const PopupMenuItem<String>(
      value: 'LIMIT',
      child: Text('LIMIT'),
    ),
    const PopupMenuItem<String>(
      value: 'ORDER BY',
      child: Text('ORDER BY'),
    ),
    const PopupMenuItem<String>(
      value: 'GROUP BY',
      child: Text('GROUP BY'),
    ),
    const PopupMenuItem<String>(
      value: 'HAVING',
      child: Text('HAVING'),
    ),
  ],
),
InkWell(
  onTap: (){
    obj.updateShow();
  },
  child: Icon(Icons.display_settings))
                 
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(!obj.show)
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
                                  vertical: 8, horizontal: 18),
                              decoration: BoxDecoration(
                                color: _buttonIndex == 0
                                    ? Color(0xFF7165D6)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Requests",
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
                                  vertical: 8, horizontal: 18),
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
                                  vertical: 8, horizontal: 18),
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
                      if(!obj.show)
                    _scheduleWidgets[_buttonIndex],
                    if(obj.show)
                    ShowScheduleAdmin()
                  ],
                ),
              ),
            ),
          ),
          if (obj.loading == true)
            Center(
                              child: SizedBox(
                                height: height * 0.1,
                                width: width * 0.2,
                                child: SpinKit.loadSpinkit,
                              ),),
        ],
      );
    
    });
  }
}
