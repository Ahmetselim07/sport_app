import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class BicepsPage extends StatelessWidget {
  TextEditingController _bicepsCurlController = TextEditingController();
  TextEditingController _hammerCurlController = TextEditingController();
  BicepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          MyCheckbox(title: Text('Biceps Curl'), controller: _bicepsCurlController, exercise: 'Biceps Curl'),
          SizedBox(height: 30,),
           MyCheckbox(title: Text('Hammer Curl'), controller: _hammerCurlController, exercise: 'Hammer Curl'),
          SizedBox(height: 30,),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}
