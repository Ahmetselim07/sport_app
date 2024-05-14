import 'package:flutter/material.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_container.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/bacak_page.dart';
import 'package:sport_app/pages/biceps_page.dart';
import 'package:sport_app/pages/gogus_page.dart';
import 'package:sport_app/pages/omuz_page.dart';
import 'package:sport_app/pages/profile_page.dart';
import 'package:sport_app/pages/s%C4%B1rt_page.dart';
import 'package:sport_app/pages/triceps_page.dart';
import 'package:sport_app/services/auth/notification_helper.dart';

class ExercisePage extends StatefulWidget {
  final bool? gogusIsOver;
  final bool? tricepsIsOver;
  ExercisePage({this.gogusIsOver, this.tricepsIsOver});

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
          const Row(
            children: [
              MyContainer(),
              MyContainer(),
              MyContainer(),
              MyContainer(),
              MyContainer(),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          getTodayExercise()
        ],
      ),
    ));
  }

  Widget getTodayExercise() {
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
              isChecked: widget.gogusIsOver,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              isChecked: widget.tricepsIsOver,
              text: 'Arka Kol',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TricepsPage(),
                ),
              ),
              showCheckbox: true,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Profil Sayfası',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            ),
            SizedBox(height: 30,),
             ElevatedButton(
                onPressed: () {
                  NotificationHelper.showNotification(
                    title: 'Bugünlük bu kadar yeter',
                    body: 'Yeni gün için sabırsızlanıyorum',
                    payload: 'Gelişiyoruz',
                  );
                },
                child: Text('Hareketleri bitir.'))
          ],
        );
      } else if (exercises[index] == 'Sırt ve Ön Kol') {
        return Column(
          children: [
            MyButton(
              text: 'Sırt',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SirtPage(),
                ),
              ),
              showCheckbox: true,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Ön Kol',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BicepsPage(),
                ),
              ),
              showCheckbox: true,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Profil Sayfası',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  NotificationHelper.showNotification(
                    title: 'Bugünlük bu kadar yeter',
                    body: 'Yeni gün için sabırsızlanıyorum',
                    payload: 'Gelişiyoruz',
                  );
                },
                child: Text('Hareketleri bitir.'))
          ],
        );
      } else if (exercises[index] == 'Omuz ve Bacak') {
        return Column(
          children: [
            MyButton(
              text: 'Omuz',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OmuzPage(),
                ),
              ),
              showCheckbox: true,
              isChecked: true,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Bacak',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BacakPage(
                    isOver: false,
                  ),
                ),
              ),
              showCheckbox: true,
              isChecked: false,
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Profil Sayfası',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            ),
            SizedBox(height: 30,),
             ElevatedButton(
                onPressed: () {
                  NotificationHelper.showNotification(
                    title: 'Bugünlük bu kadar yeter',
                    body: 'Yeni gün için sabırsızlanıyorum',
                    payload: 'Gelişiyoruz',
                  );
                },
                child: Text('Hareketleri bitir.'))
          ],
        );
      } else {
        return Text('');
      }
    }
  }
}
