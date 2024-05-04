import 'package:flutter/material.dart';

class MyGoBack extends StatelessWidget {
  const MyGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            );
  }
}