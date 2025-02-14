import 'package:chatting/helper/dialogs.dart';
import 'package:chatting/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isAnimate = false;

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimate = true;
      });
    });
  }

  handlelogin() {
    Dialogs.showProgressbar(context);
    _signInWithGoogle().then((user) {
      print("bhee$user");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  // Future<UserCredential> _signInWithGoogle() async {
  //   try {
  //     print("signiiwiiwiiwi workin");

  //     await InternetAddress.lookup('google.com');

  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: 'Sign-in was aborted by the user.',
  //       );
  //     }

  //     print("Google user signed in: $googleUser");

  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser.authentication;

  //     if (googleAuth == null) {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_GOOGLE_AUTH_FAILED',
  //         message: 'Google authentication failed.',
  //       );
  //     }
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     Dialogs.ShowSnakbar(context , "");
  //     print("Error during Google Sign-In: $e");
  //     if (e is FirebaseAuthException) {
  //       throw FirebaseAuthException(
  //         code: e.code,
  //         message: e.message,
  //       );
  //     } else if (e is SocketException) {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_NO_INTERNET',
  //         message: 'No internet connection.',
  //       );
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_UNKNOWN',
  //         message: 'An unknown error occurred.',
  //       );
  //     }
  //   }
  // }

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
                handlelogin();
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
