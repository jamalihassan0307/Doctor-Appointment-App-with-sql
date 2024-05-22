import 'package:doctor_appointment_app/screens/error_screen/primaryButton.dart';
import 'package:doctor_appointment_app/staticdata.dart';
import 'package:flutter/material.dart';


class ConnectionFailed extends StatelessWidget {
  const ConnectionFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/connection_failed.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 230,
            left: 100,
            child: Text(
              'Connection Failed',
              style: kTitleTextStyle,
            ),
          ),
          const Positioned(
            bottom: 170,
            left: 70,
            child: Text(
              'Your connection is offline,\nplease check your connection.',
              style: kSubtitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 130,
            right: 130,
            child: ReusablePrimaryButton(
              childText: 'Retry',
              buttonColor: Colors.green,
              childTextColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

