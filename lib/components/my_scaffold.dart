import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // Ekledim: Galeriye erişim için
import 'package:sport_app/components/my_drawer.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
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
  AuthService _authService = AuthService();

  File? image;

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
              pickImage(ImageSource.gallery);
              setState(() {
            
              });
               
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
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationSupportDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
}
