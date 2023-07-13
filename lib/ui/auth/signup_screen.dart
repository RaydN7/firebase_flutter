import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // initialization of firebase auth instance
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController
        .dispose(); //dispose these 2 from memory if they are not on main screen
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // back arrow removed from top of lgin screen
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                //providing column as there are multiple child
                children: [
                  TextFormField(
                    //for login and signup
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      //helperText: 'enter email id, for eg - abc@gmail.com',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    //for login and signup
                    controller: passwordController,
                    obscureText: true, //to hide password characters
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon:
                          Icon(Icons.lock_open), //icon used for password field
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } //to show highlited red error message when nothing is typed in text field and the login button is pressed
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50, //padding between login button and password text field
            ),
            RoundButton(
              title: 'Sign up',
              loading: loading,
              onTap: () {
                // null check operator used "!"
                if (_formKey.currentState!.validate()) {
                  signUp(); //fluttertoast is used to handle exception errors
                }
              },
            ),
            const SizedBox(
              height: 30, //padding between login button and password text field
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
