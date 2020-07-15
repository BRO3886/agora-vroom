import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  final String headingText;
  final String content;

  const NavigatorButton({
    Key key,
    @required this.headingText,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10,
      ),
      textTheme: ButtonTextTheme.normal,
      onPressed: () {},
      child: Row(
        children: <Widget>[
          Text(
            headingText,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          Spacer(),
          Text(
            content ?? '',
            style: TextStyle(color: Colors.grey),
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
