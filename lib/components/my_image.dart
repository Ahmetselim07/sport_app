import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyImageWidget extends StatefulWidget {
  final ValueChanged<File?> onImageSelected;

  const MyImageWidget({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _MyImageWidgetState createState() => _MyImageWidgetState();
}

class _MyImageWidgetState extends State<MyImageWidget> {
  late File? _image; // Başlangıçta null olarak başlatılır

  @override
  void initState() {
    super.initState();
    _image=null;
    _loadImage(); // İlk başta fotoğrafı yükle
  }

  // Yerel depolamadan fotoğrafı yükler
  void _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  // Fotoğrafı yerel depolamaya kaydeder
  Future<void> _saveImage(File image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', image.path);
  }

  // Galeriden fotoğraf seçer
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    final image = File(pickedImage.path);
    await _saveImage(image); // Fotoğrafı kaydet
    setState(() {
      _image = image;
    });
    widget.onImageSelected(_image);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: _image != null ? FileImage(_image!) : null,
      child: _image == null
          ? IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
            )
          : null,
    );
  }
}
