import 'package:flutter/material.dart';
import 'package:tres_det/authentication/signin_page.dart';
import 'package:tres_det/components/cards.dart';
import 'package:tres_det/screens/detection_action_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreDet - An intruder detection system',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: 'signin_screen',
      routes: {
        "signin_page": (context) => SignInPage(),
        'home_page': (context) => HomePage()
      },
      home: const SignInPage(),
    );
  }
}
