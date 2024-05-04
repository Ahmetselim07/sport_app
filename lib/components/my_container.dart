import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Color? color;
  const MyContainer({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
      ),
    );
  }
}
