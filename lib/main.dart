import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_test_app/Screens/sign_up_screen.dart';
import 'package:todo_test_app/Screens/welcome_screen.dart';
import 'Screens/styles/splash_screen1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData.dark(),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return WelcomeScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreen1();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return SignUpScreen();
      },
    );
  }
}