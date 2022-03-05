import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../message_item.dart';
import '../ntp.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Ntp ntp = Ntp();
  var loggedUser;
  String msg = "";
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    loggedUser = FirebaseAuth.instance.currentUser;
    firestore = FirebaseFirestore.instance;
    print(loggedUser.email);
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.route);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("messages")
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    var documents = snapshot.data?.docs;
                    List<Widget> list = [];
                    for (var msgJsonObject in documents!) {
                      var msgMap = msgJsonObject.data() as Map;
                      list.add(MessageItem(msgMap: msgMap, loggedUser: loggedUser));
                    }
                    return ListView(
                      reverse: true,
                      children: list,
                      padding: EdgeInsets.all(10.0),
                    );
                  }
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.black87),
                    onChanged: (value) {
                      msg = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (await sendMsg(msg)) {
                      _controller.clear();
                    }
                  },
                  child: const Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> sendMsg(String text) async {
    var time = await ntp.getTime();
    if (text.isNotEmpty) {
      print("senging msg");
      Map<String, String> map = {
        "msg": text,
        "email": loggedUser.email,
        "time": time["ntpTime"].toString()
      };
      await firestore.collection("messages").add(map);
      return true;
    } else {
      return false;
    }
  }
}


// ntp- stackOverFlow : https://stackoverflow.com/questions/64026825/how-to-get-network-datetime-now

//TODO: Modal prog bar
//TODO refactor

