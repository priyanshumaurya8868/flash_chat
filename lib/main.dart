import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData().copyWith(
        textTheme:  const TextTheme(
         bodyText1: TextStyle(color: Colors.black54),
         bodyText2: TextStyle(color: Colors.black54),
        ),
        hintColor:  Colors.black38
      ),
      title: 'Named Routes Demo',
      initialRoute: WelcomeScreen.route,
      routes: {
        LoginScreen.route: (context) =>  LoginScreen(),
        WelcomeScreen.route: (context) => WelcomeScreen(),
        RegistrationScreen.route:(context)=>RegistrationScreen(),
        ChatScreen.route :(context)=>ChatScreen()
      },
    );
  }
}
