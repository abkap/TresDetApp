import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../authentication/auth_global_credentials.dart' as auth_globals;

import 'package:tres_det/authentication/auth_global_credentials.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // This widget is the root of your application.

  @override
  void initState() {
    fetchUserFromFirebase();

    Future.delayed(Duration(seconds: 3), () {
      if (auth_globals.user == null)
        Navigator.of(context).pushReplacementNamed('signin_page');
      else
        Navigator.of(context).pushReplacementNamed('home_page');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.green,
            height: double.infinity,
            width: double.infinity,
            child: null,
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: MediaQuery.of(context).size.width / 2,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
