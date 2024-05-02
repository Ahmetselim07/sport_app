import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class SirtPage extends StatelessWidget {
  const SirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _latPulldownController = TextEditingController();
  TextEditingController _seatedCableRowController = TextEditingController();
  TextEditingController _closeGripLatPulldownController =
      TextEditingController();
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyCheckbox(
                title: Text('Lat Pulldown'),
                controller: _latPulldownController,
                exercise: 'Lat Pulldown'),
                SizedBox(height: 30,),
                MyCheckbox(
                title: Text('Seated Cable Row'),
                controller: _seatedCableRowController,
                exercise: 'Seated Cable Row'),
                SizedBox(height: 30,),
                MyCheckbox(
                title: Text('Close Grip Lat Pulldown'),
                controller: _closeGripLatPulldownController,
                exercise: 'Close Grip Lat Pulldown'),
                SizedBox(height: 30,),
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