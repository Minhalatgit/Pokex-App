import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokex/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp(
    routes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routes});

  final AppRoutes routes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: routes.getRoutes,
    );
  }
}
