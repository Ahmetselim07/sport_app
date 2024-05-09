import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_helper.dart';

class MyCheckbox extends StatefulWidget {
  final Widget title;
  final TextEditingController controller;
  final String exercise;
  final Function(bool)? onChanged;
 final bool isChecked;

  const MyCheckbox({
    Key? key,
    required this.title,
    required this.controller,
    required this.exercise,
    this.onChanged,
   required this.isChecked,
  }) : super(key: key);

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
 
  Map<String, int> savedKgs = {};

  @override
  void initState() {
    super.initState();
    _loadSavedKgs();
  }

  void _loadSavedKgs() async {
    savedKgs = await SharedPrefHelper.loadSavedKgs([widget.exercise]);
    setState(() {
      
    });
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
          value: widget.isChecked, // Dışarıdan alınan kontrol durumu kullanılıyor
          onChanged: (bool? newValue) {
            // onChanged fonksiyonu dışarıdan alınacak ve burada kullanılacak
            // Dışarıdan gelen fonksiyon çağrılacak
            widget.onChanged?.call(newValue ?? false);
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
