import 'package:flutter/material.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/gogus_page.dart';
import 'package:sport_app/pages/profile_page.dart';
import 'package:sport_app/pages/triceps_page.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<String> days = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];

  List<String> exercises = [
    'Göğüs ve Arka Kol',
    'Sırt ve Ön Kol',
    'Omuz ve Bacak'
  ];

  String currentDay = '';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    int todayIndex = now.weekday - 1;
    currentDay = days[todayIndex];
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
        children: [
          Row(
            children: [
          MyContainer(),
          MyContainer(),
          MyContainer(),
          MyContainer(),
          MyContainer(),
            ],
          ),
          
          SizedBox(height: 60,),
          getTodayExercise()
        ],
          ),
      ));
  }

  Widget getTodayExercise() {
    bool isChecked = false;
    if (currentDay == 'Perşembe' || currentDay == 'Pazar') {
      return Text('Dinlenme Günü');
    } else {
      int index = (days.indexOf(currentDay) - 1) % exercises.length;
      if (exercises[index] == 'Göğüs ve Arka Kol') {
        return Column(
          children: [
            MyButton(
              text: 'Göğüs',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GogusPage(),
                ),
              ),
              showCheckbox: true,
            ),
            SizedBox(height: 30,),
             MyButton(
      text: 'Arka Kol',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TricepsPage(),
        ),
      ),
      showCheckbox: true,
    ),
            SizedBox(height: 30,),
           MyButton(
              text: 'Profil Sayfası',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            ),
          ],
        );
      } else {
        return Text('Dinlenme Gününüz');
      }
    }
  }
}
