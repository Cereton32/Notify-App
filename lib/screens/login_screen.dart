import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pratice/screens/forget_password_screen.dart';
import 'package:firebase_pratice/screens/login_with_phoneNumber.dart';
import 'package:firebase_pratice/screens/post_screen.dart';
import 'package:firebase_pratice/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return WillPopScope(
      onWillPop: ()async{
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Login Screen", style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                20.heightBox,
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pass,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the password';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                      ),
                      20.heightBox,
                      RoundButton(
                        loading: loading,
                        name: "Login",
                        ontap: () async {
                          setState(() {
                            loading=true;
                          });
                          if (formKey.currentState!.validate()) {
                            try {
                              UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                email: _email.text.trim(),
                                password: _pass.text.trim(),
                              );

                              // Check if userCredential is not null
                              if (userCredential.user != null) {
                                print("Logged In");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                setState(() {
                                  loading=false;
                                });
                                // Navigate to another screen or perform other actions
                              }
                            } catch (e) {
                              print("Error: ${e.toString()}");
                              setState(() {
                                loading=false;
                              });
                              // Show a SnackBar with the error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login failed. ${e.toString() ?? 'Please check your credentials.'}")),
                              );
                            }
                          } else {
                            print("Form error");
                            setState(() {
                              loading=false;
                            });
                            // Optionally, show a SnackBar for form validation errors
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fix the errors in the form.')),
                            );
                          }
                        },
                      ),

                    ],
                  ),
                ),
                20.heightBox,
                Center(
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),

                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                          }, child: Text("Sign Up",style: TextStyle(
                            fontWeight: FontWeight.w700
                          ),)),

                        ],
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                      },
                          child: Text("Forgot Password"))
                    ],
                  ),
                ),
                Container(
                  width: width * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple
                  ),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));
                  },
                      child: Text("Login with Phone Number",style: TextStyle(color: Colors.white),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
