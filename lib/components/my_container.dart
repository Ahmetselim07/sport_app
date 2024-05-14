import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Color? color;
  final Widget? widget;
  const MyContainer({super.key, this.color,this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
        borderRadius: BorderRadius.circular(360),
      ),
      
    );
  }
}
