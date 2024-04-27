import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/auth/auth_gate.dart';
import 'package:sport_app/auth/login_or_register.dart';
import 'package:sport_app/firebase_options.dart';
import 'package:sport_app/pages/home_page.dart';
import 'package:sport_app/pages/login_page.dart';
import 'package:sport_app/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: lightMode,
    );
  }
}
