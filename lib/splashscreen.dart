import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: const MyHomePage(),
      title: const Text('Cataract Diagnosis',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              )),
      image: Image.asset('assets/logo.png'),
      backgroundColor: Colors.white,
      photoSize: 150,
      loaderColor: Colors.lime,
    );
  }
}
