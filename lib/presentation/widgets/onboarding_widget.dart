import 'package:flutter/material.dart';

import '../../utils/presentation/styles.dart';

class OnboardingWidget extends StatelessWidget {
  final String heading;
  final String content;
  final String imagePath;

  const OnboardingWidget({
    Key key,
    this.heading,
    this.content,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            heading,
            style: HeadingStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: SmallTextStyle,
          ),
        ],
      ),
    );
  }
}
