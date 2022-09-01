import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   'Welcome Back!',
                //   style: TextStyle(
                //     fontSize: 29,
                //   ),
                // ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.deepPurple[
                    //     200], //in case of radius, color should be specified inside the BoxDecoration
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(height: 25),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    children: [
                      // for email
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 15), //for height
                          labelText: 'Email',
                          // labelStyle: TextStyle(),
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$')
                              .hasMatch(value)) {
                            return 'Invalid Email*';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      // for password
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.key),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          } else if (!RegExp(r'^[\w]+[A-Z]').hasMatch(value)) {
                            return 'Password do not match the requirement*';
                          } else if (value.length < 7) {
                            return 'Too short';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      ElevatedButton.icon(
                        icon: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        label: Icon(Icons.login),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text.trim(),
                                      password: password.text.trim());
                              errorMsg = '';
                            } on FirebaseAuthException catch (error) {
                              errorMsg = error.message!;
                            }
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
                // InkWell(
                //   onTap: () {
                //     // forgot password code
                //   },
                //   child: Text(
                //     'Forgot password',
                //     style: TextStyle(
                //         decoration: TextDecoration.underline, fontSize: 15),
                //   ),
                // ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: widget.showSignUpPage,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  errorMsg,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
