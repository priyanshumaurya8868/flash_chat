import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  MessageItem({
    Key? key,
    required this.msgMap,
    required this.loggedUser,
  }) : super(key: key);

  final Map msgMap;
  var loggedUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: msgMap["email"] == loggedUser.email
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          msgMap["email"],
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Material(
          elevation: 5.0,
          //adaptive border radius
          borderRadius: BorderRadius.only(
              topLeft: msgMap["email"] == loggedUser.email
                  ? Radius.circular(15.0)
                  : Radius.zero,
              topRight: msgMap["email"] == loggedUser.email
                  ? Radius.zero
                  : Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          //adaptive color
          color: msgMap["email"] == loggedUser.email
              ? Colors.lightBlueAccent.shade100
              : Colors.white70,
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 15.0),
            child: Text(
              msgMap["msg"],
              style: msgMap["email"] == loggedUser.email
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}