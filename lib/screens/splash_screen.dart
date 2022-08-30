import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/home-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashActivityComplete();
  }

  void splashActivityComplete() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/weather_splash.gif',
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                "Weather App ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              // SizedBox(
              //   height: 25,
              // ),
              // const CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
