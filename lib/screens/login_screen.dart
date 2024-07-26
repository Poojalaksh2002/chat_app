import 'package:chat_app/components/roundedButtons.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;
  late String loginEmail;
  late String loginPassword;
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
                  loginEmail = value;
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
                  loginPassword = value;
                },
                decoration:
                    kTextFieldDecor.copyWith(hintText: "Enter your password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              roundedButton(
                onPressedFunction: () async {
                  setState(() {
                    showLoader = true;
                  });
                  try {
                    var loginned = await auth.signInWithEmailAndPassword(
                        email: loginEmail, password: loginPassword);

                    if (loginned != null) {
                      print('POOJA CHECK:: $loginned');
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showLoader = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.lightBlueAccent,
                title: 'Log In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
