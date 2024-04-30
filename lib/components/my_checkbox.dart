import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCheckbox extends StatefulWidget {
  final Widget title;
  final Widget subtitle;

  const MyCheckbox({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool? _isChecked = false;
  String _textFieldValue = '0';

  @override
  void initState() {
    super.initState();
    _loadTextFieldValue();
  }

  @override
  void dispose() {
    _saveTextFieldValue(_textFieldValue); // Çıkış sırasında değeri kaydet
    super.dispose();
  }

  _loadTextFieldValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textFieldValue = prefs.getString('textFieldValue') ?? '0';
    });
  }

  _saveTextFieldValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('textFieldValue', value);
  }

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
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: _textFieldValue),
              onChanged: (value) {
                setState(() {
                  _textFieldValue = value;
                });
              },
              onEditingComplete: () {
                // Klavye kapatıldığında yapılacaklar
                _saveTextFieldValue(_textFieldValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}
