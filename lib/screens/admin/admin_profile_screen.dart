// ignore_for_file: override_on_non_overriding_member, unused_local_variable

import 'dart:io';

import 'package:doctor_appointment_app/controller/admin/admin_profile_controller.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  var height, width;
  @override
  void initState() {
    super.initState();
  }

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
                                            : StaticData.doctorModel!.image !=
                                                    null
                                                ? CircleAvatar(
                                                    radius: 75,
                                                    backgroundImage:
                                                        NetworkImage(StaticData
                                                            .doctorModel!
                                                            .image!),
                                                  )
                                                : CircleAvatar(
                                                    radius: 75,
                                                    backgroundImage:
                                                        NetworkImage(obj.image
                                                            .toString()),
                                                  ),
                                      ),
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
                                                          .smalltext(
                                                        "Camera",
                                                      ),
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
                      topRight: Radius.circular(160),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 38,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Full Name"),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
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
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.phonenumber,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Phone Number"),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.address,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Address"),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
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
                              RegExp regex =
                                  RegExp(r'^(?=.*?[!@#\$&*~]).{4,}$');
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
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.specilest,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Specilest"),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Specilest';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.bio,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Bio"),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Bio';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: obj.fee,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Fee"),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Fee';
                              }

                              try {
                                double fee = double.parse(value);

                                if (fee < 0) {
                                  return 'Fee must be a non-negative value';
                                }

                                return null;
                              } catch (e) {
                                return 'Invalid fee format. Please enter a valid number.';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: obj.about,
                              minLines: 1,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("About"),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your About';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CustomWidget.largeText(
                                "   Select Available Time:",
                                height: 0.5)),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? selectedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (selectedTime != null) {
                                      obj.startTime =
                                          " ${StaticData.roundToNearestHalfHour(selectedTime).format(context)}";
                                      obj.update();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Apptheme.primary,
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    child: Center(
                                      child: Text(
                                        obj.startTime != null
                                            ? obj.startTime.toString()
                                            : "Start Time",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? selectedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (selectedTime != null) {
                                      obj.endTime =
                                          " ${StaticData.roundToNearestHalfHour(selectedTime).format(context)}";
                                      obj.update();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Apptheme.primary,
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    child: Center(
                                      child: Text(
                                        obj.endTime != null
                                            ? obj.endTime.toString()
                                            : "End Time",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CustomWidget.largeText(
                                "   Select Max Appointment Duration:",
                                height: 0.5)),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: height * 0.11,
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                itemCount: obj.time.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 18.0,
                                        mainAxisSpacing: 18.0,
                                        childAspectRatio: 3),
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      obj.updateduration(i);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: obj.duration == i
                                              ? Apptheme.primary
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(21)),
                                      child: Center(
                                          child: Text(
                                        "${obj.time[i]} Minute",
                                        style: TextStyle(
                                            color: obj.duration == i
                                                ? Colors.white
                                                : Apptheme.primary),
                                      )),
                                    ),
                                  );
                                },
                              ),
                            )),
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
                        SizedBox(
                          height: height * 0.1,
                        )
                      ],
                    ),
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
