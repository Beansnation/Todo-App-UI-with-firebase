import 'package:flutter/material.dart';
import 'styles/textStyle.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                Image.asset('assets/images/undraw.png', height: 250),
                SizedBox(
                  height: 100.0,
                ),
                Text(
                  'Organize your Todo List perfectly',
                  style: bold,
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'This app helps you monitor and evaluate your daily activities and helps your organise too. It’s the right application for achieving your goals.',
                    style: regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 100.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Get Started',
                  style: signInn,
                  ),
                  style: actionButton,
                ),
              ],
            ),
          ),
        ));
  }
}
