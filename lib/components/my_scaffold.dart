import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
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
  AuthService _authService = AuthService();
  File? image;

  @override
  void initState() {
    super.initState();
    requestPermission(); // initState içinde galeri izni iste
  }

  void requestPermission() async {
    var status = await Permission.photos.request(); // Fotoğraf izni isteği gönder

    if (status.isGranted) {
      // İzin verildiyse, fotoğraf seçme ekranını aç
      // Kullanıcı profil fotoğrafını seçtikten sonra, bu fotoğrafı kullanarak işlemleri yapabilirsiniz
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // İzin reddedildiyse veya kalıcı olarak reddedildiyse, kullanıcıya bir açıklama yapabilirsiniz
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
              onPressed: () async {
                pickImage(ImageSource.gallery,context); // Galeriyi aç
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

  Future<void> pickImage(ImageSource source,BuildContext context) async {
    try {
      final status = await Permission.photos.request(); // İzin iste
      print(status);
      if (status.isGranted) {
        final pickedImage = await ImagePicker().pickImage(source: source);
        if (pickedImage == null) return;
        final imagePermanent = await saveImagePermanently(pickedImage.path);
        setState(() {
          image = imagePermanent;
        });
      } else if (status.isDenied || status.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('İzin Gerekli'),
            content: Text('Profil fotoğrafını değiştirebilmek için galeriye erişim izni gereklidir.'),
            actions: [
              TextButton(
                onPressed: () async{
                   final pickedImage = await ImagePicker().pickImage(source: source);
        if (pickedImage == null) return;
        final imagePermanent = await saveImagePermanently(pickedImage.path);
        setState(() {
          image = imagePermanent;
        });
                },
                child: Text('İzin Ver'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kapat'),
              ),
            ],
          ),
        );
      }
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
