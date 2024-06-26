import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/components/go_back.dart';
import 'package:sport_app/components/my_image.dart';
import 'package:sport_app/pages/gogus_page.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_scaffold.dart';
import 'package:sport_app/pages/bacak_page.dart';
import 'package:sport_app/pages/biceps_page.dart';
import 'package:sport_app/pages/omuz_page.dart';
import 'package:sport_app/pages/s%C4%B1rt_page.dart';
import 'package:sport_app/pages/triceps_page.dart';
import 'package:sport_app/services/auth/notification_helper.dart';
import 'package:timezone/timezone.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final ImageProvider? image;

  ProfilePage({Key? key, this.image}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool hareketlerGizliMi = false;
  AuthService authService = AuthService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Text('No data found');
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final String name = userData['name'] ?? '';
          final String surname = userData['surname'] ?? '';
          final String height = userData['height'] ?? '';
          final String weight = userData['weight'] ?? '';
          final profileImage = widget.image;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyImageWidget(
                      onImageSelected: (value) => profileImage,
                    ),
                    Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          surname,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text("BOY   :        $height"),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text("Kilo   :        $weight")),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Tüm Hareketler',
                      style: TextStyle(fontSize: 25),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        setState(() {
                          hareketlerGizliMi = !hareketlerGizliMi;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                if (!hareketlerGizliMi) ...[
                  MyButton(
                    text: 'Göğüs',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GogusPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Triceps',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TricepsPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Biceps',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BicepsPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Sırt',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SirtPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Bacak',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BacakPage(
                                    isOver: false,
                                  )));
                    },
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: 'Omuz',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OmuzPage()));
                    },
                  ),
                  const SizedBox(height: 15),
                ],
                ElevatedButton(
                  onPressed: () async {
                    try {
                      print('içerdeyim');
                      await NotificationHelper.scheduleDailyNotification(
                        title: 'Yeni gün. Yeni hareketler',
                        body: 'Hareketleri dört gözle bekliyoruz',
                        id: 0,
                        payload: 'Merhabalar',
                      );
                    } catch (e) {
                      print('HATA OLUŞTU: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Bildirim gönderirken bir hata oluştu: $e'),
                        ),
                      );
                    }
                  },
                  child: Text('Bildirim gönder'),
                ),
                
              ],
            ),
          );
        },
      ),
     
    );
  }

  Future<DocumentSnapshot> _getUserData() async {
    final user = await authService.getCurrentUser();
    return _firestore.collection('users').doc(user!.uid).get();
  }
}
