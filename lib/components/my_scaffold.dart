import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_drawer.dart';
import 'package:sport_app/services/auth/auth_service.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  MyScaffold({
    Key? key,
    required this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  bool _permissionGranted = false;
  AuthService _authService = AuthService();
  File? image;
  late BuildContext scaffoldContext;

  @override
  void initState() {
    super.initState();
    _checkPermission(); // Sadece izin kontrolü yapılıyor
  }

  _checkPermission() async {
    PermissionStatus permissionStatus = await Permission.photos.status;
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        _permissionGranted = true;
      });
    } else {
      // İzin verilmemişse, bu noktada izin isteği yapılmalı
      _requestPermission();
    }
  }

  _requestPermission() async {
    PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        _permissionGranted = true;
      });
      // İzin bir daha sormamak için shared_preferences kullanarak izni saklanabilir
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('permissionGranted', true);
    }
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
            IconButton(
              onPressed: () {
                // Kullanıcı bir eylem gerçekleştirdiğinde izin isteği yapılıyor
                pickImage(ImageSource.gallery);
              },
              icon: image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(image!),
                    )
                  : Icon(Icons.account_circle), // Default ikon
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
      body: widget.body,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    final imagePermanent = await saveImagePermanently(pickedImage.path);
    setState(() {
      image = imagePermanent;
    });
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationSupportDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
}
