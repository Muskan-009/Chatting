// import 'package:chatting/helper/dialogs.dart';
// import 'package:chatting/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class loginScreen extends StatefulWidget {
//   const loginScreen({super.key});
//   @override
//   State<loginScreen> createState() => _loginScreenState();
// }

// class _loginScreenState extends State<loginScreen> {
//   bool isAnimate = false;
//   late Size mq;
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         isAnimate = true;
//       });
//     });
//   }

//   handleLogin() async {
//     Dialogs.showProgressbar(context);
//     try {
//       User? user = await _handlegooglesignin();
//       if (user != null) {
//         print("Logged in user: $user");
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//       } else {
//         print("Login failed, user is null");
//         Dialogs.ShowSnakbar(context, "Login failed. Please try again.");
//       }
//     } catch (e) {
//       print("Error during sign-in: $e");
//       Dialogs.ShowSnakbar(context, "Error during sign-in: $e");
//     } finally {
//       Navigator.of(context).pop();
//     }
//   }

//   // Future<User?> _signInWithGoogle() async {
//   //   try {
//   //     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   //     if (googleUser == null) {
//   //       return null;
//   //     }

//   //     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   //     OAuthCredential credential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );

//   //     UserCredential userCredential =
//   //         await FirebaseAuth.instance.signInWithCredential(credential);

//   //     return userCredential.user;
//   //   } catch (error) {
//   //     print("Error during Google Sign-In: $error");
//   //     return null;
//   //   }
//   // }

//   Future<User?> _handlegooglesignin() {
//     try {
//       GoogleAuthProvider _googleauthprovider = GoogleAuthProvider();
//       _auth.signInWithProvider(_googleauthprovider);

//     } catch (error) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: Icon(CupertinoIcons.home),
//         title: Text("We Chat"),
//       ),
//       body: Stack(
//         children: [
//           AnimatedPositioned(
//               top: mq.height * .15,
//               right: isAnimate ? mq.width * .25 : -mq.width * .5,
//               width: mq.width * .5,
//               duration: Duration(seconds: 1),
//               child: Image.asset('assets/chat.png')),
//           Positioned(
//             top: mq.height * .65,
//             left: mq.width * .1,
//             width: mq.width * .8,
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 223, 255, 186),
//                   shape: StadiumBorder()),
//               onPressed: () {
//                 handleLogin();
//               },
//               icon: Image.asset(
//                 'assets/google.png',
//                 height: 30,
//               ),
//               label: RichText(
//                 text: const TextSpan(
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                     children: [
//                       TextSpan(text: 'Sign in With'),
//                       TextSpan(
//                           text: ' Google',
//                           style: TextStyle(fontWeight: FontWeight.w500))
//                     ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
  GoogleSignIn _googleSignIn = GoogleSignIn();

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
    print("Starting the login process...");

    Dialogs.showProgressbar(context); // Show progress bar

    try {
      User? user = await _handleGoogleSignIn();
      print("user: $user");

      if (user != null) {
        // Print the user data for debugging
        print("Logged in user: $user");

        // Check if the user data is valid
        if (user.email != null && user.displayName != null) {
          print("agyaaaaaaaaaaaaaaaaaaaaaaa");
          // Navigate to HomeScreen after successful login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        } else {
          print("User data is incomplete");
          Dialogs.ShowSnakbar(
              context, "Incomplete user data. Please try again.");
        }
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

  Future<void> showAccountChooser() async {
    try {
      List<String> availableAccounts = await getAvailableAccounts();

      // If accounts are available, show a selection dialog
      if (availableAccounts.isNotEmpty) {
        String? selectedAccount = await showDialog<String>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Google Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: availableAccounts
                    .map((account) => ListTile(
                          title: Text(account),
                          onTap: () {
                            Navigator.pop(context, account);
                          },
                        ))
                    .toList(),
              ),
            );
          },
        );

        if (selectedAccount != null) {
          print('Selected Account: $selectedAccount');
          // Handle login with the selected account
          await _handleGoogleSignIn();
          print("dhjdfhsjhkjsjjkas");
          handleLogin();
        }
      }
    } catch (e) {
      print('Error fetching available accounts: $e');
    }
  }

  Future<List<String>> getAvailableAccounts() async {
    // Here, you can return a list of Google accounts from the device
    // But `google_sign_in` doesn't expose this information
    // You might need to get accounts from other means, or let Google handle this with the account chooser dialog.
    // Return mock data for now as `google_sign_in` package doesn't expose account list
    return ['muskankhan83908@gmail.com', 'anotheraccount@gmail.com'];
  }

  Future<User?> _handleGoogleSignIn() async {
    print("hsssssssssss");
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("gogogoogogoo$googleUser");
      if (googleUser == null) {
        print("dhhhhhhhhhhhhhhhhhh");
        return null; // The user canceled the sign-in
      }
      print("sadhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("googog02302n hs jsjdhf@@@${googleAuth.accessToken}");
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("credentialcredentialcredentialcredential$credential");
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("userCredentialuserCredential$userCredential");

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
                showAccountChooser(); // Ask the user to choose an account
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
