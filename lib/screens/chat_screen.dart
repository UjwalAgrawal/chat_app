import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/GfjeKSQn4vVbzSGGb1d9/messages')
            .snapshots(),
        builder: (context, streamSnapshot) {
          // if (streamSnapshot.connectionState == ConnectionState.waiting)
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/GfjeKSQn4vVbzSGGb1d9/messages')
              .add({'text': "yo nigga"});
        },
      ),
    );
  }
}
