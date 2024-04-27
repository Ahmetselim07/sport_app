import 'package:flutter/material.dart';
import 'package:sport_app/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(){
    // auth service alma
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPOR',),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              logout();
            },
            child: Image.asset('assets/images/defaultProfile.png'),
          ),
        ],
      ),
    );
  }
}
