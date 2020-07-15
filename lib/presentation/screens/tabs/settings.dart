import 'package:flutter/material.dart';

import '../../widgets/setting_options.dart';
import '../about.dart';

class SettingsScreen extends StatelessWidget {
  static const routename = "/settings";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SettingOptions(
              title: "Contacts",
              onTapHandler: () {},
            ),
            SizedBox(
              height: 20,
            ),
            SettingOptions(
              title: "Meetings",
              onTapHandler: () {},
            ),
            SizedBox(
              height: 20,
            ),
            SettingOptions(
              title: "Chats",
              onTapHandler: () {},
            ),
            SizedBox(
              height: 20,
            ),
            SettingOptions(
              title: "About",
              onTapHandler: () => Navigator.of(context).pushNamed(
                AboutScreen.routename,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
