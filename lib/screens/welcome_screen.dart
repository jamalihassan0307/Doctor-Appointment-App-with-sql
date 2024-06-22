import 'package:doctor_appointment_app/SQL/sqflite.dart';
import 'package:doctor_appointment_app/controller/admin/login_controller.dart';
import 'package:doctor_appointment_app/screens/login_screen.dart';
import 'package:doctor_appointment_app/screens/signup_screen.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
  }
var height, width;
bool _selectedDatabase = StaticData.localdatabase;
@override
Widget build(BuildContext context) {
height = MediaQuery.of(context).size.height;
width = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
               
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset("images/doctors.png"),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                " Welcome to Easy Appointment",
                style: TextStyle(
                  color: Color(0xFF7165D6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  _showTablePopup(context);
                },
                child: Text(
                  "Appoint your Doctor",
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 43, 56),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Color(0xFF7165D6),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Color(0xFF7165D6),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:height*0.02),
               SizedBox(
                height: 50,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width:width*0.1),
                     Text(
                  "Select Database",
                  style: TextStyle(
                    color: Color(0xFF7165D6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                   
                  ),),
                   Text(
                  "local",
                  style: TextStyle(
                    color: Color(0xFF7165D6),
                    fontSize: 18,
                   
                  ),),
                  Radio(value: StaticData.localdatabase?true:false, groupValue: true, onChanged: (value){
                    
                    setState(() {
                      
                       _selectedDatabase = value!;
                      StaticData.localdatabase=true;
                      
                        print("jbjkd${StaticData.localdatabase}lfjlf${value}");
                    });
                  }),
                   Text(
                  "SQL",
                  style: TextStyle(
                    color: Color(0xFF7165D6),
                    fontSize: 18,
                   
                  ),),
                  Radio<bool>(value: StaticData.localdatabase?false:true, groupValue: true, onChanged: ( value){
                   
                    setState(() {
                       _selectedDatabase = value!;
                       StaticData.localdatabase=false;
                        print("jbjkd${StaticData.localdatabase}lfjlf${value}");
                    });
                  }),
                    ],
                  ),
               )
            ],
          ),
        ),
      ),
    );
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
                        obj.fetchTableData(table).then((value) {
                         print("AAAA${ obj.tableData}");
Fluttertoast.showToast(msg: " ${obj.tableData}!",backgroundColor: Colors.red,textColor: Colors.white,gravity: ToastGravity.BOTTOM,fontSize: 17,timeInSecForIosWeb: 1,toastLength: Toast.LENGTH_LONG,);

                        });
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

}
