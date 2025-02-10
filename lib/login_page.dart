import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/forgot.dart';
import 'package:firstapp/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  }
  //   // if (_formKey.currentState!.validate()) {
  //   //   _formKey.currentState!.save();
  //   // Navigate to the next screen or display a success message
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   const SnackBar(content: Text('Login successful!')),
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        //key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Username'),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your username';
              //   }
              //   return null;
              // },
              // onSaved: (value) {
              //   setState(() {
              //     email = value! as TextEditingController;
              //   });
              // },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your password';
              //   }
              //   return null;
              // },
              // onSaved: (value) {
              //   setState(() {
              //     password = value! as TextEditingController;
              //   });
              // },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: (() => login()),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()));
              },
              child: const Text("Don't have an account? Sign up"),
            ),
            // const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Forgot()));
              },
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }
}
