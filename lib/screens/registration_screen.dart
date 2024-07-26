import 'package:chat_app/components/roundedButtons.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoader,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logohero',
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecor.copyWith(hintText: "Enter your email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kTextFieldDecor.copyWith(hintText: "Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              roundedButton(
                title: 'Register',
                onPressedFunction: () async {
                  setState(() {
                    showLoader = true;
                  });
                  try {
                    var regUser = await auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (regUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showLoader = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
