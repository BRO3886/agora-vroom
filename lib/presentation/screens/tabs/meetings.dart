import 'package:flutter/material.dart';

import '../../../utils/presentation/styles.dart';

class MeetingsScreen extends StatelessWidget {
  static const routename = "/meetings";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Meetings'),
        // leading: IconButton(
        //   icon: Icon(Icons.star),
        //   onPressed: () {},
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Personal Meeting ID',
                        style: SmallTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '651-10292-7827',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('START'),
                            onPressed: () {},
                          ),
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('SEND INVITATION'),
                            onPressed: () {},
                          ),
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('EDIT'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
