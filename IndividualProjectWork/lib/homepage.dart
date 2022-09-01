import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final userEmail = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                userEmail.email!,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 28,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 15),
              Text(
                "We are glad that you have come here to help. We really appreciate your effort. Please proceed by opening the drawer on the left side of your screen.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 15),
              Icon(
                Icons.keyboard_arrow_left,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
