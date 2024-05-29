// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_appointment_app/controller/admin/admin_profile_controller.dart';
import 'package:doctor_appointment_app/model/patient/patientmodel.dart';

class PatientProfile extends StatefulWidget {
  final PatientModel model;
  const PatientProfile({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  void initState() {
    Get.put(AdminProfileController());
    AdminProfileController.to.patientDprofile(widget.model);
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<AdminProfileController>(builder: (obj) {
      return Scaffold(
        backgroundColor: Color(0xFF7165D6),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              obj.clearprofile();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: width * 0.3,
                                height: height * 0.2,
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundImage:FileImage(
                                                        File(
                                          obj.patientimage.toString())),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(190),
                      topRight: Radius.circular(160),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 38,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, right: 32, bottom: 10),
                        child: TextFormField(
                          controller: obj.patientname,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Full Name"),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, right: 32, bottom: 10),
                        child: TextFormField(
                          controller: obj.patientemail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Email Address"),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your E-mail';
                            } else if (EmailValidator.validate(
                                    obj.email.text) ==
                                false) {
                              return 'Please enter correct E-mail';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, right: 32, bottom: 10),
                        child: TextFormField(
                          controller: obj.patientphonenumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Phone number"),
                            prefixIcon: Icon(CupertinoIcons.phone),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
