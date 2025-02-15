import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatting/main.dart';

class ChatCardScreen extends StatelessWidget {
  const ChatCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          backgroundColor: Colors.blueAccent,
        ),
        body: InkWell(
          onTap: () {
            print("taped..");
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
                title: Text("Demo"),
                subtitle: Text(
                  "Last User Message",
                  maxLines: 1,
                ),
                trailing: Text(
                  '12:00 PM',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
