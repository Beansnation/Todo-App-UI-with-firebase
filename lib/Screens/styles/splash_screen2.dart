import 'package:flutter/material.dart';
import '../welcome_screen.dart';
import 'dart:async';


class SplashScreen2 extends StatefulWidget {

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> with SingleTickerProviderStateMixin{
AnimationController controller;
Animation animation;

  @override
  void initState(){
    super.initState();
      controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,);

      animation = ColorTween(begin: Colors.white, end: Color(0xFFFF2E00)).animate(controller);

      controller.forward();
      controller.addListener((){
        setState(() {
          
        });
        print(controller.value);
      });

    Future.delayed(Duration(seconds: 5),(){
       Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                              (route) => false);
    });
  }

@override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Hero(
        tag: 'logo',
        child: Center(child: Image.asset('assets/images/logo2.png', width: 250,)))
    );
  }
}