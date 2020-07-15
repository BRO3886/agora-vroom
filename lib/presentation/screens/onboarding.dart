import 'package:flutter/material.dart';

import '../../utils/presentation/styles.dart';
import '../widgets/onboarding_widget.dart';
import 'bottom_nav.dart';

class OnboardingScreen extends StatefulWidget {
  static const routename = "/onboarding";
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController;
  int _currentPage;

  final _pageList = [
    OnboardingWidget(
      heading: 'Start a Meeting',
      content: 'Start or join a video meeting on the go',
    ),
    OnboardingWidget(
      heading: 'Share your content',
      content: 'They see what you see',
    ),
    OnboardingWidget(
      heading: 'Message your Team',
      content: 'Semd texts, voice messages, files and images',
    ),
    OnboardingWidget(
      heading: 'Get Vrooming!',
      content: 'Work anywhere, with anyone, on any device',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 12,
      width: isActive ? 12 : 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue[800] : Colors.grey[300],
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: _onPageChanged,
              itemCount: _pageList.length,
              itemBuilder: (context, index) {
                return _pageList[index];
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.36,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < _pageList.length; i++)
                          if (i == _currentPage) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width * 0.09,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'JOIN A MEETING',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius10,
                        ),
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadius10,
                          ),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                        Spacer(),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadius10,
                          ),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () =>
                              Navigator.of(context).pushReplacementNamed(
                            BottomnTabBarScreen.routename,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
