import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_helper.dart';
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

  bool _inclineChecked = false;
  bool _declineChecked = false;
  bool _pecDeckChecked = false;

  void _checkCompletion() {
    if (_inclineChecked && _declineChecked && _pecDeckChecked) {
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
              controller: _inclineController,
              exercise: 'incline',
              title: Text(
                'Incline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  _inclineChecked = value;
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyCheckbox(
              controller: _declineController,
              exercise: 'decline',
              title: Text(
                'Decline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  _declineChecked = value;
                  _checkCompletion();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyCheckbox(
              controller: _pecDeckController,
              title: Text(
                'Pec Deck Fly              4*12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              exercise: 'pecDeck',
              onChanged: (value) {
                setState(() {
                  _pecDeckChecked = value;
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
