import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class BacakPage extends StatelessWidget {
  TextEditingController _calfController = TextEditingController();
  TextEditingController _legExtensionController = TextEditingController();
   BacakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
            MyCheckbox(title: Text('Calf'), controller: _calfController, exercise: 'Calf'),
            SizedBox(height: 30,),
             MyCheckbox(title: Text('Leg Extension'), controller: _legExtensionController, exercise: 'Leg Extension'),
            SizedBox(height: 30,),
            IconButton(onPressed: 
            (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_sharp))
        ],
      ),
    );
  }
}