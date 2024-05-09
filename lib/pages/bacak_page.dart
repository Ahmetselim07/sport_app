import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/go_back.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';

class BacakPage extends StatefulWidget {
  final bool isOver;
  BacakPage({
    Key? key,
    required this.isOver,
  }) : super(key: key);

  @override
  State<BacakPage> createState() => _BacakPageState(isOver);
}

class _BacakPageState extends State<BacakPage> {
  TextEditingController _calfController = TextEditingController();
  TextEditingController _legExtensionController = TextEditingController();
  late SharedPreferences _prefs;
  bool _calfChecked = false;
  bool _legExtensionChecked = false;
  late bool _isOver;
  _BacakPageState(this._isOver);
  @override
  void initState() {
    super.initState();
    _loadCheckboxState();
  }

  Future<void> _loadCheckboxState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _calfChecked = _prefs.getBool('calfChecked') ?? false;
      _legExtensionChecked = _prefs.getBool('legExtensionChecked') ?? false;
    });
  }

  void _saveCheckboxState() {
    _prefs.setBool('calfChecked', _calfChecked);
    _prefs.setBool('legExtensionChecked', _legExtensionChecked);
  }

  void _checkCompletion() {
    if (_calfChecked && _legExtensionChecked) {
      setState(() {
        final isOver = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hareketleri tamamladınız!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyContainer(
                    color: _calfChecked ? Colors.green : Colors.grey,
                  ),
                  MyContainer(
                    color: _legExtensionChecked ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 30),
              MyCheckbox(
                title: Text('Calf Raises'),
                controller: _calfController,
                exercise: 'Calf Raises',
                isChecked: _calfChecked,
                onChanged: (value) {
                  setState(() {
                    _calfChecked = value;
                    _saveCheckboxState();
                    _checkCompletion();
                  });
                },
              ),
              SizedBox(height: 30),
              MyCheckbox(
                title: Text('Leg Extension'),
                controller: _legExtensionController,
                exercise: 'Leg Extension',
                isChecked: _legExtensionChecked,
                onChanged: (value) {
                  setState(() {
                    _legExtensionChecked = value;
                    _saveCheckboxState();
                    _checkCompletion();
                  });
                },
              ),
              SizedBox(height: 30),
              MyGoBack(),
            ],
          ),
        ),
      ),
    );
  }
}
