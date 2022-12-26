import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenAuth extends StatelessWidget {
  const LoginScreenAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("==========="),
          ElevatedButton(
            onPressed: () async {
              // print(await FirebaseMessaging.instance.getToken());
              // try {
              //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
              //       email: "marwan@gmail.com", password: "marwan2017");
              //   return null;
              // } on FirebaseAuthException catch (ex) {
              //   print("${ex.code}: ${ex.message}");
              // }
            },
            child: Text("login"),
          )
        ],
      ),
    );
  }
}
