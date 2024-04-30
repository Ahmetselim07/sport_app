import 'package:flutter/material.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:sport_app/components/my_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(){
    // auth service alma
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(),
    );
  }
}
