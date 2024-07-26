import 'package:chat_app/components/roundedButtons.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<Color?> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    //animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.orange, end: Colors.lightBlue)
        .animate(controller!);

    // to start animation
    controller!.forward();
    animation!.addStatusListener((status) {
      print(animation!.status);
    });

    controller!.addListener(() {
      setState(() {});
      print(animation!.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      // Colors.red.withOpacity(animation!.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logohero',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: 60,
                    // animation!.value * 100,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            roundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Log In',
              onPressedFunction: () {
                Navigator.pushNamed(context, LoginScreen.id);
                //Go to login screen.
              },
            ),
            roundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressedFunction: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
                //Go to registration screen.
              },
            ),
          ],
        ),
      ),
    );
  }
}
