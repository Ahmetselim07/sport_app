import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/exercise_page.dart';
import 'package:sport_app/pages/profile_page.dart';

class TricepsPage extends StatefulWidget {
  TricepsPage({super.key});

  @override
  State<TricepsPage> createState() => _TricepsPageState();
}

class _TricepsPageState extends State<TricepsPage> {
  TextEditingController _dipsMachineController = TextEditingController();

  TextEditingController _tricepsPushDownController = TextEditingController();

  bool _dipsMachineChecked = false;
  late SharedPreferences _prefs;
  bool _tricepsPushDownChecked = false;
  bool _tricepsIsOver = false;
  bool _gogusIsOver =false;
  void _checkCompletion() {
    if (_dipsMachineChecked && _tricepsPushDownChecked) {
      setState(() {
        _tricepsIsOver = true;
      });
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
      _dipsMachineChecked = _prefs.getBool('dipsMachineChecked') ?? false;
      _tricepsPushDownChecked =
          _prefs.getBool('tricepsPushDownChecked') ?? false;
    });
  }

  void _saveCheckboxState() {
    _prefs.setBool('dipsMachineChecked', _dipsMachineChecked);
    _prefs.setBool('tricepsPushDownChecked', _tricepsPushDownChecked);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyContainer(
                color: _dipsMachineChecked ? Colors.green : Colors.grey,
              ),
              MyContainer(
                color: _tricepsPushDownChecked ? Colors.green : Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          MyCheckbox(
            isChecked: _dipsMachineChecked,
            title: Text('Dips Machine'),
            controller: _dipsMachineController,
            exercise: 'Dips Machine',
            onChanged: (value) {
              setState(() {
                _dipsMachineChecked = value;
                _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                _checkCompletion();
              });
            },
          ),
          MyCheckbox(
            isChecked: _tricepsPushDownChecked,
            title: Text('Triceps PushDown'),
            controller: _tricepsPushDownController,
            exercise: 'Triceps PushDown',
            onChanged: (value) {
              setState(() {
                _tricepsPushDownChecked = value;
                _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                _checkCompletion();
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePage(
                      tricepsIsOver: _tricepsIsOver,
                    
                    ),
                  ),
                );
              },
              child: Text('Egzersiz Sayfasına Git')),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ));
  }
}
