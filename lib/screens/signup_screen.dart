import 'package:doctor_appointment_app/controller/admin/signup_controller.dart';
import 'package:doctor_appointment_app/screens/login_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    Get.put(SignupController());
    super.initState();
  }

  final GlobalKey<FormState> form = GlobalKey<FormState>();
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<SignupController>(builder: (obj) {
      return Material(
        color: Colors.white,
        child: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("images/doctors.png"),
                ),
                SizedBox(
                  height: height * 0.17,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          obj.updateindex(0);
                        },
                        child: CustomWidget.smallcontainer(
                            bordercolor:
                                obj.index == 0 ? Apptheme.primary : null,
                            radius: 20,
                            height: height * 0.15,
                            width: width * 0.3,
                            child: SizedBox(
                              height: height * 0.2,
                              child: Column(
                                children: [
                                  Image(
                                      height: height * 0.12,
                                      image: AssetImage(
                                          "images/doctor_logo-removebg-preview.png")),
                                  Text("Doctor")
                                ],
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          obj.updateindex(1);
                        },
                        child: CustomWidget.smallcontainer(
                            bordercolor:
                                obj.index == 1 ? Apptheme.primary : null,
                            radius: 20,
                            height: height * 0.15,
                            width: width * 0.3,
                            child: SizedBox(
                              height: height * 0.2,
                              child: Column(
                                children: [
                                  Image(
                                      height: height * 0.12,
                                      image: AssetImage(
                                          "images/patient_logo.png")),
                                  Text("Patient")
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: obj.fullname,
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
                      } else if (EmailValidator.validate(obj.email.text) ==
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
                if (obj.index == 0)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: obj.address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Address"),
                        prefixIcon: Icon(Icons.home),
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
                if (obj.index == 0)
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: obj.specilest,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Specialist"),
                        prefixIcon: Icon(Icons.density_large_sharp),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Specialist';
                        }
                        return null;
                      },
                    ),
                  ),
                if (obj.index == 0)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: obj.bio,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Bio"),
                        prefixIcon: Icon(Icons.recycling),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Bio';
                        }
                        return null;
                      },
                    ),
                  ),
                if (obj.index == 0)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: obj.fee,
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
                if (obj.index == 0)
                  SizedBox(
                    height: height * 0.12,
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
                if (obj.index == 0)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomWidget.largeText("   Select Available Time:",
                          height: height * 0.002)),
                if (obj.index == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * 0.06,
                        width: width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
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
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (selectedTime != null) {
                                obj.endTime =
                                    "${StaticData.roundToNearestHalfHour(selectedTime).format(context)}";
                                // obj.endTime =
                                //     " ${selectedTime.format(context)}";
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
                if (obj.index == 0)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomWidget.largeText(
                          "   Select Max Appointment Duration:",
                          height: height * 0.003)),
                if (obj.index == 0)
                  SizedBox(
                      height: height * 0.10,
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
                                    borderRadius: BorderRadius.circular(21)),
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
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Material(
                      color: Color(0xFF7165D6),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          // DateTime time = obj.parseTime("12:00 PM");
                          // print("Time${time}");
                          if (form.currentState!.validate()) {
                            obj.index == 0
                                ? obj.register(context)
                                : obj.register1(context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Center(
                            child: Text(
                              "Creat Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account ?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7165D6),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
