// import 'dart:convert';
import 'dart:io';

// import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/Sql_query.dart';
import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/model/admin/DoctorModel.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';
// import 'package:doctor_appointment_app/controller/patient/patientController.dart';
import 'package:doctor_appointment_app/screens/patient/appointment_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height, width;
  @override
  void initState() {
    if (LoginController.to.tables.isEmpty) {
      gettable();
    }
    
    super.initState();
  }

  gettable() async {
    LoginController.to.tables = await SQLService.getAllTables();
    LoginController.to.update();
  }

  void _showTablePopup(BuildContext context) {
    if (LoginController.to.tables.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select a Table'),
            content: GetBuilder<LoginController>(builder: (obj) {
              return SingleChildScrollView(
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
            }),
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    // gettable();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<LoginController>(builder: (obj) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${StaticData.patientmodel!.fullname}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // if (StaticData.localdatabase) {
                          obj.updatetable(!obj.showtable);
                        // }
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              FileImage(File(StaticData.patientmodel!.image))),
                    ),
                    // if (StaticData.localdatabase)
                      IconButton(
                        icon: Icon(Icons.more_vert_outlined),
                        onPressed: () => _showTablePopup(context),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      StaticData.openEmailChat();
                    },
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.email,
                              color: Apptheme.primary,
                              size: 35,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            " Email",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Contact to Clinic",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      String user1 = "1fd0278c-d841-4a1e-8ea2-b7e874237569";
                      String user2 = "15617030-613d-497a-944b-9810bec14c4c";
                      String a = StaticData.chatRoomId(user1, user2);
                      String id1 = a.replaceAll(RegExp(r'[^a-zA-Z]'), '');
                      print("data1${a}  sdsf${id1}");
                      print("2qweqweqeqeqwe        ${a}");
                      // StaticData.openWhatsAppChat();
                    },
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chat,
                              color: Color(0xFF7165D6),
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "WhatsApp",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Contact to Clinic",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: InkWell(
                  onTap: () {
                    print("DATA${obj.tableData}");
                  },
                  child: Text(
                    !obj.showtable
                        ? "Popular Doctors"
                        : obj.selectedTable +
                            " " +
                            obj.tableData!.length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              Center(
                  child: obj.tableData!.isNotEmpty && obj.showtable
                      ? SizedBox(
                          height: height * 0.5,
                          child: ListView.builder(
                            itemCount: obj.tableData!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () async {
                                    // SQLQuery.delecttable("VisterUser");
                                    // var qurery =
                                    //     'CREATE TABLE VisterUser (id VARCHAR(255)  PRIMARY KEY,patientid VARCHAR(255),doctorid VARCHAR(255));';
                                    // SQLQuery.createTabledata(qurery);

                                    // obj.tableData!.forEach((element) {
                                    //   PatientModel modelda6ta =
                                    //       PatientModel.fromMap(element);
                                    //   modelda6ta.doctorList!.forEach((element) {
                                    //     var id = StaticData.chatRoomId(
                                    //       modelda6ta.id,
                                    //       element,
                                    //     ).replaceAll(RegExp(r'[^a-zA-Z]'), '');
                                    //     VisterUser user = VisterUser(
                                    //         id: id,
                                    //         patientid:
                                    //             //  element,
                                    //             modelda6ta.id,
                                    //         doctorid:
                                    //             // modelda6ta.id
                                    //             element);
                                    //     print("VisterUser=$user");
                                    //     try {
                                    //       SQLQuery.postdata(
                                    //           "INSERT INTO VisterUser VALUES (${user.toMap()})");
                                    //     } catch (e) {}
                                    //   });
                                    // });
                                    gettable();

                                    print("DATA${obj.tableData![index]}");
                                  },
                                  tileColor: Colors.white,
                                  autofocus: true,
                                  subtitleTextStyle: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  focusColor: Colors.red,
                                  title: Text("${(index + 1).toString()}"),
                                  subtitle:
                                      Text(obj.tableData![index].toString()),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          width: width * 0.95,
                          child: obj.alldoctor.length == 0
                              ? Center(
                                  child: CustomWidget.largeText(
                                      'Data not found !'),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 0),
                                  itemCount: obj.alldoctor.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context1, index) {
                                    var model = obj.alldoctor[index];
                                    return InkWell(
                                      onTap: () {
                                        model = obj.alldoctor[index];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentScreen(
                                                      model: model),
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                                  FileImage(File(model.image!)),
                                            ),
                                            Text(
                                              "Dr.${model.fullname}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              "${model.specialty}",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 236, 182, 18),
                                                  size: 11,
                                                ),
                                                Text(
                                                  "Ratting:${(model.totalrating / model.ratingperson).isNaN ? "0" : (model.totalrating / model.ratingperson)}",
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ))
            ],
          ),
        ),
      );
    });
  }
}
