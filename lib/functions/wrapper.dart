import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:firstapp/screens/login_page.dart';
import 'package:flutter/material.dart';

class WrapperState extends StatefulWidget {
  const WrapperState({super.key});

  @override
  State<WrapperState> createState() => _WrapperStateState();
}

class _WrapperStateState extends State<WrapperState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WelcomeScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
