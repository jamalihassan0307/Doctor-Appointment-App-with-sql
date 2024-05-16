import 'dart:io';

import 'package:doctor_appointment_app/controller/patient/profileController.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
 
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<ProfileController>(builder: (obj) {
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
                                  child: Stack(
                                    children: [
                                            Align(
                                        alignment: Alignment.center,
                                        child: obj.hpickedFile != null
                                            ? Container(
                                                height: height * 0.15,
                                                width: width * 0.3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            obj.hpickedFile!
                                                                .path)),
                                                        fit: BoxFit.fill)),
                                                // radius: 75,
                                              )
                                            :StaticData.patientmodel!.image!=null?
                                            CircleAvatar(
                                                radius: 75,
                                                backgroundImage: NetworkImage(
                                                   StaticData.patientmodel!.image),
                                              )
                                            
                                            : CircleAvatar(
                                                radius: 75,
                                                backgroundImage: NetworkImage(
                                                    obj.image.toString()),
                                              ),
                                      ),
                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: obj.hpickedFile != null
                                      //       ? Container(
                                      //           height: height * 0.15,
                                      //           width: width * 0.3,
                                      //           decoration: BoxDecoration(
                                      //               shape: BoxShape.circle,
                                      //               image: DecorationImage(
                                      //                   image: FileImage(File(
                                      //                       obj.hpickedFile!
                                      //                           .path)),
                                      //                   fit: BoxFit.fill)),
                                      //           // radius: 75,
                                      //         )
                                      //       : CircleAvatar(
                                      //           radius: 75,
                                      //           backgroundImage: NetworkImage(
                                      //               obj.image.toString()),
                                      //         ),
                                      // ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      title: CustomWidget
                                                          .largeText(
                                                              "Profile photo"),
                                                    ),
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                        child: Icon(
                                                          Icons.add_a_photo,
                                                          color:
                                                              Apptheme.primary,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      title: CustomWidget
                                                          .smalltext("Camera"),
                                                      onTap: () {
                                                        obj.pickImage(
                                                            ImageSource.camera);

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor: Colors
                                                            .grey.shade300,
                                                        child: Icon(
                                                          Icons.photo,
                                                          color:
                                                              Apptheme.primary,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      title: CustomWidget
                                                          .smalltext("Gallery"),
                                                      onTap: () {
                                                        obj.pickImage(
                                                            ImageSource
                                                                .gallery);

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Colors.white.withOpacity(.9),
                                            child: Icon(Icons.edit),
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
                          controller: obj.name,
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
                          controller: obj.email,
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
                          obscureText: obj.passToggle ? true : false,
                          controller: obj.password,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter Password"),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                if (obj.passToggle == true) {
                                  obj.passToggle = false;
                                } else {
                                  obj.passToggle = true;
                                }
                                obj.update();
                              },
                              child: obj.passToggle
                                  ? Icon(CupertinoIcons.eye_slash_fill)
                                  : Icon(CupertinoIcons.eye_fill),
                            ),
                          ),
                          obscuringCharacter: "*",
                          validator: (String? value) {
                            RegExp regex = RegExp(r'^(?=.*?[!@#\$&*~]).{4,}$');
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else {
                              if (value.length < 5) {
                                return ("Password Must be more than 5 characters");
                              } else if (!regex.hasMatch(value)) {
                                return ("Password should contain Special character or number");
                              } else {
                                return null;
                              }
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 41,
                          child: Material(
                            color: Color(0xFF7165D6),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                obj.updateprofile(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Center(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
