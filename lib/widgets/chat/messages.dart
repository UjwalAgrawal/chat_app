import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.docs;
        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index]['text'],
            FirebaseAuth.instance.currentUser.uid == chatDocs[index]['userId'],
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
