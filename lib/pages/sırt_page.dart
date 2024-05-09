import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';

class SirtPage extends StatefulWidget {
  const SirtPage({super.key});

  @override
  State<SirtPage> createState() => _SirtPageState();
}

class _SirtPageState extends State<SirtPage> {
  TextEditingController _latPulldownController = TextEditingController();
  TextEditingController _seatedCableRowController = TextEditingController();
  TextEditingController _closeGripLatPulldownController =
      TextEditingController();
  bool _latPulldownChecked = false;
  late SharedPreferences _prefs;
  bool _seatedCableRowChecked = false;
  bool _closeGripLatPulldownChecked = false;
  void _checkCompletion() {
    if (_closeGripLatPulldownChecked &&
        _latPulldownChecked &&
        _seatedCableRowChecked) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hareketleri tamamladınız!"),
        ),
      );
    }
  }
  @override
    void initState() {
      super.initState();
      _loadCheckboxState();
      _checkCompletion();
    }

    Future<void> _loadCheckboxState() async {
      _prefs = await SharedPreferences.getInstance();
      setState(() {
        // Varsayılan değerler eklemek için ?? operatörü kullanılıyor
        _latPulldownChecked = _prefs.getBool('latPulldownChecked') ?? false;
        _seatedCableRowChecked =
            _prefs.getBool('seatedCableRowChecked') ?? false;
        _closeGripLatPulldownChecked =
            _prefs.getBool('closeGripLatPulldownChecked') ?? false;
      });
    }

    void _saveCheckboxState() {
      _prefs.setBool('latPulldownChecked', _latPulldownChecked);
      _prefs.setBool('seatedCableRowChecked', _seatedCableRowChecked);
      _prefs.setBool(
          'closeGripLatPulldownChecked', _closeGripLatPulldownChecked);
    }

  @override
  Widget build(BuildContext context) {
    

    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer(
                  color: _latPulldownChecked ? Colors.green : Colors.grey,
                ),
                MyContainer(
                  color: _seatedCableRowChecked ? Colors.green : Colors.grey,
                ),
                MyContainer(
                  color: _closeGripLatPulldownChecked ? Colors.green : Colors.grey,
                )
      
              ],
            ),
            SizedBox(height: 30,),
            MyCheckbox(
              isChecked: _latPulldownChecked,
              title: Text('Lat Pulldown'),
              controller: _latPulldownController,
              exercise: 'Lat Pulldown',
              onChanged: (value) {
                setState(() {
                  _latPulldownChecked = value;
                  _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            MyCheckbox(
                isChecked: _seatedCableRowChecked,
                onChanged: (value) {
                  setState(() {
                    _seatedCableRowChecked = value;
                    _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                    _checkCompletion();
                  });
                },
                title: Text('Seated Cable Row'),
                controller: _seatedCableRowController,
                exercise: 'Seated Cable Row'),
            SizedBox(
              height: 30,
            ),
            MyCheckbox(
              isChecked: _closeGripLatPulldownChecked,
              title: Text('Close Grip Lat Pulldown'),
              controller: _closeGripLatPulldownController,
              exercise: 'Close Grip Lat Pulldown',
              onChanged: (value) {
                setState(() {
                  _closeGripLatPulldownChecked = value;
                  _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
