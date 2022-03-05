import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../round_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "/registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _processing = false;
  var _email;
  var _pswd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 200.0,
                child: Hero(
                  tag: 'logo',
                  child: Flexible(child: Image.asset('images/logo.png')),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
              style: TextStyle(color: Colors.black87),
              decoration: kRegTextFieldDecoration.copyWith(
                  hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                _pswd = value;
              },
              style: TextStyle(color: Colors.black87),
              decoration: kRegTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Flexible(
              child: RoundButton(
                  text: "Register",
                  color: Colors.blueAccent,
                  onTap: () {
                    registration(_email, _pswd);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void registration(String email, String pswd) async {
    try {
      var newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pswd);
      if (newUser != null) {
        Navigator.pushNamed(context, ChatScreen.route);
      }
    } catch (e) {
      print(e);
    } finally {
      _processing = false;
    }
  }
}
