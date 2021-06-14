import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_test_app/Screens/styles/splash_screen3.dart';
import 'styles/textStyle.dart';
import 'sign_up_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner =false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  String fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: ListView(
      children: [
        SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/logo2.png', width: 150),
          SizedBox(width: 16.0),
          Text(
            'sign in',
            style: signIn,
          )
        ]),
        SizedBox(height: 16.0),
        Center(
          child: Text(
            'Welcome Back',
            style: bold,
          ),
        ),
        SizedBox(height: 150.0),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: regular,
            ),
            SizedBox(height: 8.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: kdecoration('input a valid email address'),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            Text(
              'Password',
              style: regular,
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: kdecoration('minimum of 6 characters'),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
                   children:[Text(
                'Forgot Password?',
                 textAlign: TextAlign.right,
                style: regular,
              )],
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen3()),
                        (route) => false);
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                'Sign in',
                style: signInn,
              ),
              style: actionButton,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New User?  ', style: regular),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Sign up',
                    style: regular2,
                  ),
                )
              ],
            )
          ],
        ))
      ],
            ),
          ),
        ),
    );
  }
}
