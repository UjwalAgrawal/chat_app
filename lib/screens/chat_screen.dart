import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/GfjeKSQn4vVbzSGGb1d9/messages')
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
    );
  }
}
