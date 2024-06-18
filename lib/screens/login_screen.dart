import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/screens/signup_screen.dart';
import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:doctor_appointment_app/util/customwidgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.white,
      child: GetBuilder<LoginController>(builder: (obj) {
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.08,
                  width: width,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Select Profile",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7165D6),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.2,
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
                                  Text(
                                    "Doctor",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7165D6),
                                    ),
                                  ),
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
                                  Text(
                                    "Patient",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7165D6),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: obj.email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter User Email Address"),
                        prefixIcon: Icon(Icons.person_outline),
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
                ),
                SizedBox(
                  child: Padding(
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
                            setState(() {});
                          },
                          child: obj.passToggle
                              ? Icon(CupertinoIcons.eye_slash_fill)
                              : Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                      obscuringCharacter: '*',
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
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Material(
                      color: Color(0xFF7165D6),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            obj.index == 0
                                ? obj.signInWithEmailAndPassword(context)
                                : obj.signInWithEmailAndPassword1(context);
                          } else {}
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have any account ?",
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
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Creat Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7165D6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
