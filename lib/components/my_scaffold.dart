import 'package:flutter/material.dart';
import 'package:sport_app/components/my_drawer.dart';
import 'package:sport_app/services/auth/auth_service.dart';

class MyScaffold extends StatelessWidget {
  AuthService _authService = AuthService();
  final Widget body;
  final Color? color;
  final Widget? bottomNavigationBar;

  MyScaffold({
    Key? key,
    required this.body,
    this.color,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: Text('SPOR', style: TextStyle(fontSize: 30)),
          actions: [
            Image.asset(
              'assets/images/defaultProfile.png',
              height: 60,
            ),
            SizedBox(width: 20),
          ],
          
        ),
      ),

      body: body,
    );
  }
}
