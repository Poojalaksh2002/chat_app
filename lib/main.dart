import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// *** Solution present in firebase config issue: ***
// https://medium.com/@zaidbinkhalid/resolving-firebase-configuration-error-in-flutter-a-step-by-step-guide-70c5a5a146da

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:
          "AIzaSyBa0gibyvIou2r0zH_-T7sHten9u9A8tsI", // present in google-services.json file =>current_key
      appId:
          "1:437059088411:android:0d087fd8dbb92f0744c8be", //present in google-services.json file =>mobilesdk_app_id
      messagingSenderId:
          "437059088411", //present in google-services.json file => project_number
      projectId:
          "flash-chat-f66ec", //present in google-services.json file =>project_id
    ),
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      theme: ThemeData.dark().copyWith(),
    );
  }
}
