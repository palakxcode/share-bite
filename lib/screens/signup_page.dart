import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/auth/wrapper.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firstapp/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  signup() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.text, password: pw.text);
    Get.offAll(const WrapperState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Page")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(label: Text("Username")),
            ),
            TextField(
              controller: pw,
              decoration: const InputDecoration(label: Text("Password")),
            ),
            ElevatedButton(
                onPressed: (() => signup()), child: const Text("SignUp")),
          ],
        ),
      ),
    );
  }
}
