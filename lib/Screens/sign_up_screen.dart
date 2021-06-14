import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:todo_test_app/Screens/styles/splash_screen3.dart';
import 'styles/textStyle.dart';


class SignUpScreen extends StatefulWidget {
  @override 
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 
  FirebaseAuth _auth = FirebaseAuth.instance;
  String fullName;
  String email;
  String password;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
      children: [
         SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/logo2.png', width: 150),
          SizedBox(width: 16.0),
          Text(
            'sign up',
            style: signIn,
          )
        ]),
        SizedBox(height: 16.0),
        Center(
          child: Text(
            'Welcome Onboard',
            style: bold,
          ),
        ),
        SizedBox(height: 80.0),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: regular,
            ),
            SizedBox(height: 8.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: kdecoration('input your first and last name'),
              onChanged: (value) {
                fullName = value;
              },
            ),
            SizedBox(height: 32.0),
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
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                 
                });
                final newUser =
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                if (newUser != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SplashScreen3()),
                      (route) => false);
                }
              },
              child: Text(
                'Register',
                style: signInn,
              ),
              style: actionButton,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a User?  ', style: regular),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Sign in',
                    style: regular2,
                  ),
                ),
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
