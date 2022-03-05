import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/round_button.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _email;
  var _pswd;
  bool _processing = false;

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
                  tag: "logo",
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black87),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
              decoration: kLoginTextFieldDecoration.copyWith(
                  hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black87),
              obscureText: true,
              onChanged: (value) {
                _pswd = value;
              },
              decoration: kLoginTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Flexible(
              child: RoundButton(
                  text: "Login",
                  color: Colors.lightBlueAccent,
                  onTap: () async {
                    await login(_email, _pswd);
                  }),
            ),
            Visibility(
              visible: _processing,
              child: Flexible(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Future login(String email, String pswd) async {
    try {
      var newUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pswd);
      if (newUser != null) {
        Navigator.pushNamed(context, ChatScreen.route);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _processing = false;
      });
    }
  }
}
