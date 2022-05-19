import 'dart:async';

import 'package:engaged/screens/constants/constants.dart';
import 'package:engaged/screens/home.dart';
import 'package:engaged/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    var isLoggedIn = getUserLogin();
    debugPrint("IS LOGGED IN: $isLoggedIn");

    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                isLoggedIn ? const HomePage() : const LoginPage()),
                (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = const AssetImage('assets/images/Logo.png');
    var image = Image(image: assetsImage, height: 300);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: image,
        ),
      ),
    );
  }
}
