import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/pages/exercise_page.dart';
import 'package:sport_app/pages/home_page.dart';
import 'package:sport_app/pages/profile_page.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:sport_app/themes/dark_mode.dart';
import 'package:sport_app/themes/light_mode.dart';
import 'package:sport_app/themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  AuthService authService = AuthService();
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Ana Sayfa'),
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
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dark Mode'),
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
