import 'package:agora_vroom/presentation/screens/about.dart';
import 'package:agora_vroom/presentation/screens/tabs/contacts.dart';
import 'package:agora_vroom/presentation/screens/tabs/meetings.dart';
import 'package:agora_vroom/presentation/screens/tabs/settings.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/bottom_nav.dart';
import 'presentation/screens/tabs/home.dart';
import 'presentation/screens/onboarding.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showSemanticsDebugger: true,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        canvasColor: Colors.grey[200],
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: OnboardingScreen(),
      routes: {
        HomeScreen.routename: (context) => HomeScreen(),
        MeetingsScreen.routename: (context) => MeetingsScreen(),
        ContactsScreen.routename: (context) => ContactsScreen(),
        SettingsScreen.routename: (context) => SettingsScreen(),
        AboutScreen.routename: (context) => AboutScreen(),
        BottomnTabBarScreen.routename: (context) => BottomnTabBarScreen(),
      },
    );
  }
}
