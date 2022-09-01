import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';
import 'auth_page.dart';

class UserLoginCheck extends StatelessWidget {
  const UserLoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Center(child: Text('Something went wrong'));
          // }
          if (snapshot.hasData) {
            return Homepage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
