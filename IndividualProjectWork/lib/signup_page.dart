import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Get Registered',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Create account'),
                SizedBox(height: 40),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    children: [
                      //for username
                      TextFormField(
                        controller: username,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          labelText: 'Username',
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
                          } else if (value.length > 10) {
                            return 'Username can\'t exceed 10 digits*';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      // for email
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        // onChanged: (String value) {},
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
                      SizedBox(height: 5),
                      Text(
                        errorMsg,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 10),
                      //for password
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
                        // onChanged: (String value) {},
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
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        label: Icon(Icons.login),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email.text.trim(),
                                      password: password.text.trim());
                              errorMsg = '';
                            } on FirebaseAuthException {
                              // use 'catch ()' for default error message
                              errorMsg =
                                  "*Email already in use by another user!"; //custom error message
                            }
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: widget.showLoginPage,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => LoginPage()));
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SignUpConfirmation extends StatelessWidget {
//   const SignUpConfirmation({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('You have been registered.'),
//             SizedBox(height: 10),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) => LoginPage()));
//               },
//               child: Text(
//                 'Proceed to Login',
//                 style: TextStyle(
//                     fontSize: 17,
//                     decoration: TextDecoration.underline,
//                     color: Colors.blue),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
