import 'package:flutter/material.dart';
import '../../Screens/styles/splash_screen2.dart';
import 'dart:async';

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashScreen2()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(controller.value),
        body: Hero(
            tag: 'logo',
            child: Center(
                child: Image.asset(
              'assets/images/logo1.png',
              width: 200,
            ))));
  }
}
