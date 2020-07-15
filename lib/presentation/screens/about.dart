import 'package:flutter/material.dart';

import '../widgets/navigator_button.dart';

class AboutScreen extends StatelessWidget {
  static const routename = "/about";
  const AboutScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  NavigatorButton(
                    headingText: 'Version',
                    content: '1.0.0+22',
                  ),
                  Divider(),
                  NavigatorButton(
                    headingText: 'Report a Problem',
                  ),
                  Divider(),
                  NavigatorButton(
                    headingText: 'Tell Others About Vroom',
                  ),
                  Divider(),
                  NavigatorButton(
                    headingText: 'Rate Vroom on Play Store',
                  ),
                  Divider(),
                  NavigatorButton(
                    headingText: 'Privacy Policy',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
