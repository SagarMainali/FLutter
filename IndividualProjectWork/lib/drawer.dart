import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_login_check.dart';
import 'homepage.dart';
import 'view_tickets.dart';
import 'generate_tickets.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final userEmail = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple[300],
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 150,
                child: ClipOval(
                  child: Image.network(
                    "https://thumbs.dreamstime.com/b/boy-face-avatar-profile-picture-boy-wearing-glasses-face-avatar-profile-picture-cartoon-character-portrait-vector-illustration-149758816.jpg",
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              accountName: Text(
                "Sagar Mainali",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              accountEmail: Text(userEmail.email!),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      "View Tickets",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.view_array,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewTickets()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Generate Tickets",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GenerateTickets()));
                    },
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((res) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLoginCheck()),
                        );
                      });
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
