import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_drawer.dart';
import 'package:sport_app/components/my_image.dart';
import 'package:sport_app/services/auth/auth_service.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  MyScaffold({Key? key, required this.body, this.bottomNavigationBar}) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  AuthService _authService = AuthService();
  late File? _image;

  @override
  void initState() {
    super.initState();
    _getImageFromPrefs();
  }

  _getImageFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      _image = File(imagePath);
    }
  });
}

  _saveImageToPrefs(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: Text('SPOR', style: TextStyle(fontSize: 30)),
          actions: [
            MyImageWidget(
  onImageSelected: (File? image) {
    if (image != null) {
      _saveImageToPrefs(image.path);
    }
    setState(() {
      _image = image;
    });
  },
),
            SizedBox(width: 20),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
