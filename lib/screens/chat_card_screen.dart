import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatting/main.dart';

class ChatCardScreen extends StatelessWidget {
  const ChatCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: mq.width * .04),
          // color: Colors.blue.shade100,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Chat"),
  //       backgroundColor: Colors.blueAccent,
  //     ),
  //     body: ListView.builder(
  //       itemCount: 10,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           leading: CircleAvatar(
  //             backgroundColor: Colors.blue,
  //             child: Text("U${index + 1}"),
  //           ),
  //           title: Text("User ${index + 1}"),
  //           subtitle: Text("This is message number ${index + 1}"),
  //           trailing: Icon(Icons.chat),
  //           onTap: () {
  //             print("Tapped on message ${index + 1}");
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
