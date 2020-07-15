import 'package:flutter/material.dart';

import '../../utils/presentation/styles.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function onPressed;
  final String heading;

  const CustomIconButton({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.onPressed,
    @required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 100,
      child: Column(
        children: <Widget>[
          RaisedButton(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius10.add(
                BorderRadius.circular(5),
              ),
            ),
            textColor: Colors.white,
            child: Icon(icon),
            color: color,
            onPressed: onPressed,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: SmallTextStyle,
          )
        ],
      ),
    );
  }
}
