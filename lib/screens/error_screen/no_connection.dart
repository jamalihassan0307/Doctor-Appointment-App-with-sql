import 'package:doctor_appointment_app/screens/error_screen/primaryButton.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  @override
  Widget build(BuildContext context) {
    print("sdsdfsd");
    return SafeArea(
      child: Scaffold(
        body: 
        
        Stack(
          children: [
            Image.asset(
              'images/Connection_Lost.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            const Positioned(
              bottom: 200,
              left: 30,
              child: Text(
                'No Connection',
                style: kTitleTextStyle,
              ),
            ),
            const Positioned(
              bottom: 150,
              left: 30,
              child: Text(
                'Please check your internet connection\nand try again.',
                style: kSubtitleTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 40,
              right: 40,
              child: ReusablePrimaryButton(
                childText: 'Retry',
                buttonColor: Colors.blue[800]!,
                childTextColor: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}