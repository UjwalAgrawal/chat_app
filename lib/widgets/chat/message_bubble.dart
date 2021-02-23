import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(
    this.msg,
    this.username,
    this.userImage,
    this.isMe, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    // print();
    return Stack(children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            SizedBox(
              width: 10,
            ),
          if (!isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(
                userImage,
              ),
            ),
          Flexible(
            child: Container(
              // width: 200,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              margin: EdgeInsets.fromLTRB(isMe ? 50 : 8, 4, isMe ? 8 : 50, 4),
              decoration: BoxDecoration(
                color:
                    isMe ? Colors.grey.shade300 : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.zero : Radius.circular(12),
                  bottomRight: isMe ? Radius.zero : Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          if (isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(
                userImage,
              ),
            ),
          if (isMe)
            SizedBox(
              width: 10,
            ),
        ],
      ),
    ]);
  }
}
