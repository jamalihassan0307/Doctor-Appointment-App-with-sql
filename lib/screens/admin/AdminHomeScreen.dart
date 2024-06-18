// import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/controller/admin/admin_home_controller.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/screens/admin/patient_profile.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var height, width;
  void initState() {
   gettable();
    super.initState();
  }
  gettable()async{
LoginController.to.tables= await SQLService.getAllTables();
LoginController.to.update();
  }
 void _showTablePopup(BuildContext context) {
  if (LoginController.to.tables.isNotEmpty) {
      showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a Table'),
          content:  GetBuilder<LoginController>(
                builder: (obj) {
                  return  SingleChildScrollView(
                      child: Column(
                        children: obj.tables.map((table) {
                          return ListTile(
                            title: Text(table),
                            onTap: () {
                              Navigator.of(context).pop();
                              obj.fetchTableData(table);
                            },
                          );
                        }).toList(),
                      ),
                    );
                }
              ),
        );
      },
    );
 
  }
   }
 
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<AdminHomeController>(builder: (obj) {
      return GetBuilder<AdminHomeController>(builder: (obj) {
        return GetBuilder<LoginController>(
          builder: (login) {
            return Material(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 25),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.65,
                              child: Text(
                                "Dr.${StaticData.doctorModel!.fullname}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                              InkWell(
                          onTap: (){
                            if (StaticData.localdatabase) {
                              login.updatetable(!login.showtable);
                            }
                           
                          },
                        
                              child: CircleAvatar(
                                
                                radius: 30,
                                backgroundImage:FileImage(
                                                              File(StaticData.doctorModel!.image!)),
                              ),
                            ),
                               if(StaticData.localdatabase)
                
                   IconButton(
                                icon: Icon(Icons.more_vert_outlined),
                                onPressed: () => _showTablePopup(context),
                              ),
                
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${obj.allPatients.length}",
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w400,
                                        color: Apptheme.primary),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Total patient",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Apptheme.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {},
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${obj.schedule}",
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w400,
                                        color: Apptheme.primary),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "  Schedule  ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Apptheme.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                         !login.showtable?  "All My Patients":login.selectedTable+" "+login.tableData!.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Center(
                        child: 
                        
                        
                          login.tableData!.isNotEmpty&&login.showtable
            ? SizedBox(
              height: height*0.5,
                child: ListView.builder(
                  itemCount: login.tableData!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: (){
                          print("DATA${login.tableData![index]}");
                        },
                        tileColor: Colors.white,
                        autofocus: true,
                        subtitleTextStyle: TextStyle(fontSize: 13,color: Colors.black),
                        focusColor: Colors.red,
                        title: Text("${(index+1).toString()}"),
                        subtitle: Text(login.tableData![index].toString()),
                      ),
                    );
                  },
                ),
              )
            :
                        SizedBox(
                          width: width * 0.95,
                          child: obj.allPatients.isEmpty
                              ? SizedBox(
                                  height: height * 0.4,
                                  child: Center(
                                    child: CustomWidget.largeText('No Patient !'),
                                  ),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2, childAspectRatio: 1.1),
                                  itemCount: obj.allPatients.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var patientModel = obj.allPatients[index];
                                    return InkWell(
                                      onTap: () {
                                        var patientModel = obj.allPatients[index];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PatientProfile(
                                                  model: patientModel),
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage:FileImage(
                                                            File(patientModel.image)),
                                            ),
                                            Text(
                                              "${patientModel.fullname}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "ph:${patientModel.phonenumber}",
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      });
    });
  }
}
