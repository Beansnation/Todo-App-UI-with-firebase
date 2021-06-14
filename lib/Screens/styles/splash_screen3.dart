import 'package:flutter/material.dart';
import '../home_screen.dart';
import 'dart:async';


class SplashScreen3 extends StatefulWidget {

  @override
  _SplashScreen3State createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status){
      if (status ==AnimationStatus.completed){
        controller.reverse(from: 1.0);
      }else if(status ==AnimationStatus.dismissed){
        controller.forward();
      }
    });

      controller.forward();
      controller.addListener((){
        setState(() {});
        print(controller.value);
      });

    Future.delayed(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
      backgroundColor: Colors.black.withOpacity(controller.value),
      body: Hero(
        tag: 'logo',
        child: Center(child: Image.asset('assets/images/logo2.png', width: animation.value * 200,)))
    );
  }
}