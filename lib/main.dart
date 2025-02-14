import 'package:firebase_core/firebase_core.dart';
import 'package:chatting/screens/auth/login_Screen.dart';
import 'package:flutter/material.dart';

late Size mq;
void main() {
  //full screen
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // //
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  intiliazefirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'We Chat',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 19,
          ),
          backgroundColor: Colors.white,
        )),
        home: loginScreen());
  }
}

void intiliazefirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
