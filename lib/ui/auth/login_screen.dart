import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/ui/auth/login_with_phone_number.dart';
import 'package:firebase_project/ui/auth/signup_screen.dart';
import 'package:firebase_project/ui/forgot_password.dart';
import 'package:firebase_project/ui/posts/post_screen.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController
        .dispose(); //dispose these 2 from memory if they are not on main screen
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          // to take to the PostScreen after succesfull login
          context,
          MaterialPageRoute(builder: (context) => const PostScreen()));
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      debugPrint(error.toString());
      Utils().toastMessage(
          error.toString()); // Create an instance and call the method
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); //to exit the app using buttons on device
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              false, // back arrow removed from top of lgin screen
          title: const Text('Login'),
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
                        prefixIcon: Icon(
                            Icons.lock_open), //icon used for password field
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
                height:
                    50, //padding between login button and password text field
              ),
              RoundButton(
                title: 'Login',
                loading:
                    loading, //to show circular loading animation on login button
                onTap: () {
                  // null check operator used "!"
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text('Forgot Password'),
                ),
              ),
              const SizedBox(
                height:
                    30, //padding between login button and password text field
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ), // for mobile verfication
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(child: Text('Login with Phone Number')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
