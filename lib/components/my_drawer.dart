import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/pages/exercise_page.dart';
import 'package:sport_app/pages/home_page.dart';
import 'package:sport_app/pages/profile_page.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:sport_app/services/auth/notification_helper.dart';
import 'package:sport_app/themes/theme_provider.dart';

@immutable
class MyDrawer extends StatelessWidget {
  final AuthService authService = AuthService();
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool? _gosusIsOver;
    bool? _tricepsIsOver;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage())),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Ana sayfa'),
                )),
            MyButton(
              text: 'Egzersizlerim',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(),
                ),
              ),
            ),
            MyButton(
              text: 'Profil',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      }),
                ],
              ),
            ),
            MyButton(
              text: 'Bildirimleri İptal Et',
              onTap: () async {
                NotificationHelper.unScheduleAllNotifications();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Yeni gün bildirimi iptal edildi')),
                );

                print('ok');
              },
            ),
            IconButton(
                onPressed: () {
                  authService.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
