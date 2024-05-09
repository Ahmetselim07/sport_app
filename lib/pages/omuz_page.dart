import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/go_back.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';

class OmuzPage extends StatefulWidget {

  OmuzPage({super.key});

  @override
  State<OmuzPage> createState() => _OmuzPageState();
}

class _OmuzPageState extends State<OmuzPage> {
  TextEditingController _shoulderPressController = TextEditingController();

  TextEditingController _lateralController = TextEditingController();

  TextEditingController _facePullController = TextEditingController();

  bool _shoulderPressChecked = false;

  bool _lateralChecked = false;

  bool _facePullChecked = false;

  @override
  Widget build(BuildContext context) {
       void _checkCompletion(isOver) {
    if (_facePullChecked && _lateralChecked && _shoulderPressChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hareketleri tamamladınız!"),
        ),
      );
    }
  }
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                 MyContainer(
                    color: _shoulderPressChecked ? Colors.green : Colors.grey,
                  ),
                  MyContainer(
                    color: _lateralChecked ? Colors.green : Colors.grey,
                  ),
                  MyContainer(
                    color: _facePullChecked ? Colors.green : Colors.grey,
                  ),
              ],
            ),
            SizedBox(height: 30,),
            MyCheckbox(
              onChanged: (value) {
                setState(() {
                  _shoulderPressChecked = value;
                  _checkCompletion(context);
                });
              },
                isChecked: _shoulderPressChecked,
                title: Text('Dumbbell Shoulder Press'),
                controller: _shoulderPressController,
                exercise: 'Dumbbell Shoulder Press'),
            SizedBox(
              height: 30,
            ),
            MyCheckbox(
              onChanged: (value) {
                setState(() {
                  _lateralChecked = value;
                  _checkCompletion(context);
                });
              },
                isChecked: _lateralChecked,
                title: Text('Lateral Raise'),
                controller: _lateralController,
                exercise: 'Lateral Raise'),
            SizedBox(
              height: 30,
            ),
            MyCheckbox(
                isChecked: _facePullChecked,
                
                title: Text('Face Pull'),
                controller: _facePullController,
                exercise: 'Face Pull',
                onChanged: (value) {
                setState(() {
                  _facePullChecked = value;
                  _checkCompletion(context);
                });
              },
                ),
            SizedBox(
              height: 30,
            ),
            MyGoBack(),
          ],
        ),
      ),
    );
  }
}
