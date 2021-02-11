import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _msgController = TextEditingController();
  var _enteredMsg = '';

  void _sendMsg() {
    // FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMsg,
      'createdAt': Timestamp.now(),
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: InputDecoration(
                hintText: "Let's start typing...",
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMsg = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMsg.trim().isEmpty ? null : _sendMsg,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
