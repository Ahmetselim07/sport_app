import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/components/my_checkbox.dart';
import 'package:sport_app/components/my_helper.dart';
import 'package:sport_app/components/my_scaffold.dart';

class GogusPage extends StatefulWidget {
  
  GogusPage({Key? key}) : super(key: key);

  @override
  State<GogusPage> createState() => _GogusPageState();
}

class _GogusPageState extends State<GogusPage> {
  final TextEditingController _inclineController = TextEditingController();
  final TextEditingController _declineController = TextEditingController();
  final TextEditingController _pecDeckController = TextEditingController();

  

  
    // TextField'ı sıfırla
   

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
              controller: _inclineController,
              exercise: 'incline',
              title: Text(
                'Incline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              controller: _declineController,
              exercise: 'decline',
              
              title: Text(
                'Decline Chest Press  4*8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            
            SizedBox(
              height: 20,
            ),
            MyCheckbox(
              controller:_pecDeckController,
              title: Text(
                'Pec Deck Fly              4*12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), exercise: 'pecDeck',
            ),
            SizedBox(
              height: 10,
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
