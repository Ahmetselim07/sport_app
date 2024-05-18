import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/exercise_page.dart';

  bool _bicepsChecked = false;
  bool _hammerChecked = false;
  bool _bicepsIsOver = false;


class BicepsPage extends StatefulWidget {
  late final isOver;
  BicepsPage({super.key});

  @override
  State<BicepsPage> createState() => _BicepsPageState();
}

class _BicepsPageState extends State<BicepsPage> {
  TextEditingController _bicepsCurlController = TextEditingController();

  TextEditingController _hammerCurlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    void _checkCompletion(isOver) {
    if (_bicepsChecked && _hammerChecked) {
      setState(() {
        _bicepsIsOver =true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hareketleri tamamladınız!"),
        ),
      );
    }
  }
   
    return MyScaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer(
                  color: _bicepsChecked ? Colors.green : Colors.grey,
                ),
                MyContainer(
                  color: _hammerChecked ? Colors.green : Colors.grey,
                ),
      
              ],
            ),
            SizedBox(height: 30,),
          MyCheckbox(
            isChecked: _bicepsChecked,
              title: Text('Biceps Curl'),
              controller: _bicepsCurlController,
              exercise: 'Biceps Curl',
              onChanged: (value) {
                setState(() {
                  _bicepsChecked = value;
                  _checkCompletion(context);
                });
              },
              ),
          SizedBox(
            height: 30,
          ),
          MyCheckbox(
            isChecked: _hammerChecked,
              title: Text('Hammer Curl'),
              controller: _hammerCurlController,
              exercise: 'Hammer Curl',
              onChanged: (value) {
                setState(() {
                  _hammerChecked = value;
                  _checkCompletion(context);
                });
              },
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
                      bicepsIsOver: _bicepsIsOver,
                    
                    ),
                  ),
                );
              },
              child: Text('Egzersiz Sayfasına Git')),
              SizedBox(height: 30,),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}
