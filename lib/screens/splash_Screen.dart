import 'package:chatting/screens/auth/login_Screen.dart';
import 'package:chatting/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      if (FirebaseAuth.instance.currentUser != null) {
        print("working...");
        print("\nUSer=>${FirebaseAuth.instance.currentUser}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const loginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              left: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('assets/chat.png')),
          Positioned(
              top: mq.height * .65,
              width: mq.width,
              child: const Text(
                textAlign: TextAlign.center,
                "MAde In India with log ❤️",
                style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
              )),
        ],
      ),
    );
  }
}
