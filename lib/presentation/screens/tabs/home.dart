import 'package:flutter/material.dart';

import '../../../utils/presentation/styles.dart';
import '../../widgets/icon_button.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Meet & Chat'),
        leading: IconButton(
          icon: Icon(Icons.star),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            color: Theme.of(context).canvasColor,
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                  ),
                  hintText: 'Search',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomIconButton(
                  color: Colors.orange,
                  icon: Icons.video_call,
                  onPressed: () {},
                  heading: 'New Meeting',
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.add_box,
                  heading: 'Join',
                  onPressed: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.calendar_today,
                  onPressed: () {},
                  heading: 'Schedule',
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.screen_share,
                  onPressed: () {},
                  heading: 'Share Screen',
                ),
              ],
            ),
            Divider(
              thickness: 10,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }
}
