import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/exercise_page.dart';
import 'package:sport_app/pages/profile_page.dart';

class TricepsPage extends StatelessWidget {
  TextEditingController _dipsMachineController = TextEditingController();
  TextEditingController _tricepsPushDownController = TextEditingController();
  TricepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: Column(
      children: [
        MyCheckbox(
            title: Text('Dips Machine'),
            controller: _dipsMachineController,
            exercise: 'Dips Machine'),
        SizedBox(
          height: 50,
        ),
        MyCheckbox(
            title: Text('Triceps PushDown'),
            controller: _tricepsPushDownController,
            exercise: 'Triceps PushDown'),
            SizedBox(height: 30,),
            
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ));
  }
}
