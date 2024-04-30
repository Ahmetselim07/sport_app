import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_scaffold.dart';

class GogusPage extends StatefulWidget {
  const GogusPage({super.key});

  @override
  State<GogusPage> createState() => _GogusPageState();
}

class _GogusPageState extends State<GogusPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'GÖĞÜS KİLOLAR',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MyCheckbox(
              subtitle: Text(
                '4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Incline Chest Press',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              subtitle: Text(
                '4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Decline Chest Press',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              subtitle: Text(
                '4*12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(
                'Pec Deck Fly',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
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
