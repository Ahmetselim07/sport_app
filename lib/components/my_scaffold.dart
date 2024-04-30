import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_drawer.dart';
import 'package:sport_app/services/auth/auth_service.dart';

class MyScaffold extends StatelessWidget {
  AuthService _authService = AuthService();
  final Widget body;
  final Color? color;
  final Widget? bottomNavigationBar;
   MyScaffold({
    super.key,
    required this.body,
    this.color, 
    this.bottomNavigationBar, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: IconButton(onPressed: (){
        _authService.signOut();
      }, icon: Icon(Icons.logout)),),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SPOR', style: TextStyle(fontSize: 25)),
                  Image.asset(
                    'assets/images/defaultProfile.png',
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
