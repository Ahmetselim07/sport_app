import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        MyCheckbox(title: Text('Hey'), subtitle: Text('123'),controller: _dipsMachineController,),
        MyCheckbox(title: Text('Hey'), subtitle: Text('123'), controller: _tricepsPushDownController)
      ],
    ));
  }
}
