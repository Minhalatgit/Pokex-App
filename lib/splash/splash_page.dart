import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokex/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splash.png"),
      ),
    );
  }

  void _checkLogin() {
    Future.delayed(const Duration(milliseconds: 500), () {
      String route;
      if (_auth.currentUser == null) {
        route = AppRoutes.loginPage;
      } else {
        route = AppRoutes.homePage;
      }
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    });
  }
}
