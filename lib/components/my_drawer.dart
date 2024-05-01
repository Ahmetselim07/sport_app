import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sport_app/themes/dark_mode.dart';
import 'package:sport_app/themes/light_mode.dart';
import 'package:sport_app/themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.only(top:50.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dark Mode'),
                  CupertinoSwitch(
                    value:Provider.of<ThemeProvider>(context,listen: false).isDarkMode, onChanged: (value){
                    Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}