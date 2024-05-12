import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/exercise_page.dart';

class GogusPage extends StatefulWidget {
  const GogusPage({Key? key}) : super(key: key);

  @override
  State<GogusPage> createState() => _GogusPageState();
}

class _GogusPageState extends State<GogusPage> {
  final TextEditingController _inclineController = TextEditingController();
  final TextEditingController _declineController = TextEditingController();
  final TextEditingController _pecDeckController = TextEditingController();

  late SharedPreferences _prefs;
  bool _inclineChecked = false;
  bool _declineChecked = false;
  bool _pecDeckChecked = false;
  bool _gogusIsOver = false; // _isOver değişkeni eklenmiştir
  bool _tricepsIsOver = false;
  @override
  void initState() {
    super.initState();
    _loadCheckboxState();
    _checkCompletion();
  }

  void _checkCompletion() {
    if (_inclineChecked && _declineChecked && _pecDeckChecked) {
      setState(() {
        _gogusIsOver = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hareketleri tamamladınız!"),
        ),
      );
    }
  }

  Future<void> _loadCheckboxState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Varsayılan değerler eklemek için ?? operatörü kullanılıyor
      _inclineChecked = _prefs.getBool('inclineChecked') ?? false;
      _declineChecked = _prefs.getBool('declineChecked') ?? false;
      _pecDeckChecked = _prefs.getBool('pecDeckChecked') ?? false;
    });
  }

  void _saveCheckboxState() {
    _prefs.setBool('inclineChecked', _inclineChecked);
    _prefs.setBool('declineChecked', _declineChecked);
    _prefs.setBool('pecDeckChecked', _pecDeckChecked);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'GÖĞÜS KİLOLAR',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer(
                  color: _inclineChecked ? Colors.green : Colors.grey,
                ),
                MyContainer(
                  color: _declineChecked ? Colors.green : Colors.grey,
                ),
                MyContainer(
                  color: _pecDeckChecked ? Colors.green : Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              isChecked: _inclineChecked,
              controller: _inclineController,
              exercise: 'incline',
              title: Text(
                'Incline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  _inclineChecked = value;
                  _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyCheckbox(
              isChecked: _declineChecked,
              controller: _declineController,
              exercise: 'decline',
              title: Text(
                'Decline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  _declineChecked = value;
                  _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyCheckbox(
              isChecked: _pecDeckChecked,
              controller: _pecDeckController,
              title: Text(
                'Pec Deck Fly              4*12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              exercise: 'pecDeck',
              onChanged: (value) {
                setState(() {
                  _pecDeckChecked = value;
                  _saveCheckboxState(); // Checkbox durumları değiştiğinde kaydedin
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 10,
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
                        gogusIsOver: _gogusIsOver,
                       
                        ),
                          
                       
                      ));
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
      ),
    );
  }
}
