import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_helper.dart';

class MyCheckbox extends StatefulWidget {
  final Widget title;
  final TextEditingController controller;
  final String exercise;
  final Function(bool)? onChanged;

  const MyCheckbox({
    Key? key,
    required this.title,
    required this.controller,
    required this.exercise,
    this.onChanged,
  }) : super(key: key);

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool _isChecked = false;
  Map<String, int> savedKgs = {};

  @override
  void initState() {
    super.initState();
    _loadSavedKgs();
  }

  void _loadSavedKgs() async {
    savedKgs = await SharedPrefHelper.loadSavedKgs([widget.exercise]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          title: widget.title,
          subtitle: Text(
            'Kaydedilen kg: ${savedKgs[widget.exercise] ?? 0}',
          ),
          activeColor: Colors.orange,
          tileColor: Colors.black54,
          checkColor: Colors.white,
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue!;
              widget.onChanged?.call(newValue);
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SharedPrefHelper.buildKgInputAndSaveButton(
            controller: widget.controller,
            exercise: widget.exercise,
            onSaved: () {
              _loadSavedKgs();
            },
          ),
        ),
      ],
    );
  }
}
