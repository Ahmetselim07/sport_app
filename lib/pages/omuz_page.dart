import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class OmuzPage extends StatelessWidget {
  TextEditingController _shoulderPressController = TextEditingController();
  TextEditingController _lateralController = TextEditingController();
  TextEditingController _facePullController = TextEditingController();
  OmuzPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyCheckbox(
                title: Text('Dumbbell Shoulder Press'),
                controller: _shoulderPressController,
                exercise: 'Dumbbell Shoulder Press'),
                SizedBox(height: 30,),
                MyCheckbox(
                title: Text('Lateral Raise'),
                controller: _lateralController,
                exercise: 'Lateral Raise'),
                SizedBox(height: 30,),
                MyCheckbox(
                title: Text('Face Pull'),
                controller: _facePullController,
                exercise: 'Face Pull'),
                SizedBox(height: 30,),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            )
          ],
        ),
      ),
    );
  }
}
