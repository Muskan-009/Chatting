import 'package:chatting/helper/dialogs.dart';
import 'package:chatting/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isAnimate = false;
  late Size mq;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimate = true;
      });
    });
  }

  handleLogin() async {
    Dialogs.showProgressbar(context);

    try {
      User? user = await _signInWithGoogle();

      if (user != null) {
        print("Logged in user: $user");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        print("Login failed, user is null");
        Dialogs.ShowSnakbar(context, "Login failed. Please try again.");
      }
    } catch (e) {
      print("Error during sign-in: $e");
      Dialogs.ShowSnakbar(context, "Error during sign-in: $e");
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<User?> _signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (error) {
      print("Error during Google Sign-In: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(CupertinoIcons.home),
        title: Text("We Chat"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              top: mq.height * .15,
              right: isAnimate ? mq.width * .25 : -mq.width * .5,
              width: mq.width * .5,
              duration: Duration(seconds: 1),
              child: Image.asset('assets/chat.png')),
          Positioned(
            top: mq.height * .65,
            left: mq.width * .1,
            width: mq.width * .8,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 255, 186),
                  shape: StadiumBorder()),
              onPressed: () {
                handleLogin();
              },
              icon: Image.asset(
                'assets/google.png',
                height: 30,
              ),
              label: RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(text: 'Sign in With'),
                      TextSpan(
                          text: ' Google',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
