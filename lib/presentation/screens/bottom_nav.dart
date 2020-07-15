import 'package:agora_vroom/presentation/screens/tabs/contacts.dart';
import 'package:agora_vroom/presentation/screens/tabs/settings.dart';
import 'package:flutter/material.dart';

import 'tabs/home.dart';
import 'tabs/meetings.dart';

class BottomnTabBarScreen extends StatefulWidget {
  static const routename = "/bottom";

  @override
  _BottomnTabBarScreenState createState() => _BottomnTabBarScreenState();
}

class _BottomnTabBarScreenState extends State<BottomnTabBarScreen> {
  int _currentIndex;

  List<Widget> _pageList = [
    HomeScreen(),
    MeetingsScreen(),
    ContactsScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  onPageSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onPageSelected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.3),
        backgroundColor: Theme.of(context).canvasColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text('Meet & Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Meetings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Contacts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
