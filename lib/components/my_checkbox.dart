import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCheckbox extends StatefulWidget {
  final Widget title;
  final Widget subtitle;

  const MyCheckbox({Key? key, required this.title, required this.subtitle,})
      : super(key: key);

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool? _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: CheckboxListTile(
              autofocus: true,
              hoverColor: Colors.red,
              controlAffinity: ListTileControlAffinity.trailing,
              title: widget.title,
              subtitle: widget.subtitle,
              activeColor: Colors.orange,
              tileColor: Colors.black54,
              checkColor: Colors.white,
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue;
                });
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            
          ),
        ),
      ],
    );
  }
}
