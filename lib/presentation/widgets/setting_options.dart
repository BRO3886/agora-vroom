import 'package:flutter/material.dart';

class SettingOptions extends StatelessWidget {
  final String title;
  final Function onTapHandler;

  const SettingOptions({
    Key key,
    @required this.title,
    @required this.onTapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: InkWell(
        onTap: onTapHandler,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Text(title),
              Spacer(),
              Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
