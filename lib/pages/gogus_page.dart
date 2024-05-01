import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class GogusPage extends StatefulWidget {
  GogusPage({Key? key}) : super(key: key);

  @override
  State<GogusPage> createState() => _GogusPageState();
}

class _GogusPageState extends State<GogusPage> {
  final TextEditingController _inclineController = TextEditingController();
  final TextEditingController _declineController = TextEditingController();
  final TextEditingController _pecDeckController = TextEditingController();

  Map<String, int> savedKgs = {};

  @override
  void initState() {
    super.initState();
    _loadSavedKgs();
  }

  void _loadSavedKgs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedKgs['incline'] = prefs.getInt('incline') ?? 0;
      savedKgs['decline'] = prefs.getInt('decline') ?? 0;
      savedKgs['pecDeck'] = prefs.getInt('pecDeck') ?? 0;
    });
  }

  void _saveHowMuchKg(String exercise, int kg) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(exercise, kg);
    setState(() {
      savedKgs[exercise] = kg;
    });
    // TextField'ı sıfırla
    if (exercise == 'incline') {
      _inclineController.clear();
    } else if (exercise == 'decline') {
      _declineController.clear();
    } else if (exercise == 'pecDeck') {
      _pecDeckController.clear();
    }
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
            MyCheckbox(
              subtitle: Text(
                'Kaydedilen kg: ${savedKgs['incline']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Incline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildKgInputAndSaveButton(
              controller: _inclineController,
              exercise: 'incline',
            ),
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              subtitle: Text(
                'Kaydedilen kg: ${savedKgs['decline']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Decline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildKgInputAndSaveButton(
              controller: _declineController,
              exercise: 'decline',
            ),
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              subtitle: Text(
                'Kaydedilen kg: ${savedKgs['pecDeck']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Pec Deck Fly               4*12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildKgInputAndSaveButton(
              controller: _pecDeckController,
              exercise: 'pecDeck',
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

  Widget _buildKgInputAndSaveButton({
    required TextEditingController controller,
    required String exercise,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'KG',
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            int kg = int.tryParse(controller.text) ?? 0;
            _saveHowMuchKg(exercise, kg);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$exercise kg saved: $kg')),
            );
          },
        ),
      ],
    );
  }
}
