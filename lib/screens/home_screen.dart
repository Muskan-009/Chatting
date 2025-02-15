import 'dart:convert';

import 'package:chatting/api/api.dart';
import 'package:chatting/screens/chat_card_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatting/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(CupertinoIcons.home),
        title: Text("We Chat"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: StreamBuilder(
        stream: Apis.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            print(
                "spss=>${jsonEncode(snapshot.data?.docs.map((doc) => doc.data()).toList())}");
            final data = snapshot.data?.docs;
            final list = data
                    ?.map((doc) => doc.data() as Map<String, dynamic>)
                    .toList() ??
                [];
            print("listt=${list}");

            return ListView.builder(
              itemCount: list.length,
              padding: EdgeInsets.only(top: mq.height * .01),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var user = list[index];
                return ListTile(
                  title: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(user['name'] ?? 'No name'),
                        Text(user['name'] ?? 'No name'),
                        Text(user['name'] ?? 'No name'),
                        Text(user['name'] ?? 'No name'),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatCardScreen(
                            // Passing user data to the chat screen
                            ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
    );
  }
}
