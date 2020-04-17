import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/App/app.dart';
import 'package:covid19/Utils/ListAnimater.dart';
import 'package:covid19/Utils/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Color(0xFF5779DB) : Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: SafeArea(
            child: ClipRRect(
                          child: Scaffold(
          backgroundColor: Color(0xFFF2F2F9),
          body: Container(
              height: double.infinity,
              child: Container(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    _currentPage = page;
                    setState(() {});
                  },
                  children: <Widget>[
                    _buildPageContent(
                        image: 'assets/PlainMap.png',
                        title: 'Keep eyes on Novel Corona Virus',
                        body:
                            'Get updates about Novel Corona Virus, confirmed by WHO.  Keep track of the situation due to Coronavirus in your country and update yourself with the latest feeds about COVID-19. Equip yourself with all the required info about Corona Virus.'),
                    _buildPageContent(
                        image: 'assets/strongGirl.png',
                        title: 'Get Stronger to face COVID-19',
                        body: 
                            'During Home Quarantine, work upon yourself and enhance immunity and mental health to best fight with Corona Virus. Meditate and keep track of water drunk daily. Know how to deal with COVID-19.'),
                    _lastPage(
                        image: 'assets/people.png',
                        title: 'Let\'s make it Defeat',
                        body:
                            'Novel Corona Virus is a global pandemic, which is very dangerous for life on the planet. Let\'s fight and make it defeat, let\'s unite this world and save life on our planet. Let\'s be one. ')
                  ],
                ),
              ),
          ),
          bottomSheet: _currentPage != 2
                ? Container(
                  color: Color(0xFFF2F2F9),
                    //margin: EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      height: 60.0,
                      color: Color(0xFFF2F2F9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                            ),
                                                      child: FlatButton(
                              onPressed: () {
                                _pageController.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                                setState(() {});
                              },
                              splashColor: Colors.blue[50],
                              child: Text(
                                'SKIP',
                                style: TextStyle(color: Color(0xFF6F8EE4), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(children: [
                              for (int i = 0; i < _totalPages; i++) i == _currentPage ? _buildPageIndicator(true) : _buildPageIndicator(false)
                            ]),
                          ),
                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                            ),
                                                      child: FlatButton(
                              onPressed: () {
                                _pageController.animateToPage(_currentPage + 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                                setState(() {});
                              },
                              splashColor: Colors.blue[50],
                              child: Text(
                                'NEXT',
                                style: TextStyle(color: Color(0xFF5779DB), fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : InkWell(
                  splashColor: Colors.transparent,
                    onTap: () {
                   signInWithGoogle().whenComplete(() {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) {
                return MainPage();
              },
          ),
        );
      });
      },
                    child: Container(
                      height: Platform.isIOS ? 70 : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: Color(0xFF5779DB),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
        ),
            ),
      ),
    );
  }

  Widget _buildPageContent({
    String image,
    String title,
    String body,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: SizedBox(), flex:2),
          FadeIn(
                      2, Container(
              height: 300,
              width: 300,
              child: Center(
                child: Image.asset(image),
              ),
            ),
          ),
          Expanded(child: SizedBox(), flex:2),
          FadeIn(
               2.5, AutoSizeText(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (MediaQuery.of(context).size.width> 400 && MediaQuery.of(context).size.width < 420)
                                ? MediaQuery.of(context).size.width * 0.037
                                : MediaQuery.of(context).size.width * 0.045, height: 2.0, fontWeight: FontWeight.w600, color: Color(0xFF3F3F3F)),
            ),
          ),
          SizedBox(height: 10),
          FadeIn(
                3.0,  AutoSizeText(
              body,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (MediaQuery.of(context).size.width> 400 && MediaQuery.of(context).size.width < 420)
                                ? MediaQuery.of(context).size.width * 0.032
                                : MediaQuery.of(context).size.width * 0.037, height: 2.0),
            ),
          ),
          Expanded(child: SizedBox(), flex:4),
        ],
      ),
    );
  }

  Widget _lastPage({
    String image,
    String title,
    String body,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FadeIn(
                      2, Center(
              child: Image.asset(image),
            ),
          ),
          SizedBox(height: 70),
          FadeIn(
                2.5, AutoSizeText(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (MediaQuery.of(context).size.width> 400 && MediaQuery.of(context).size.width < 420)
                                ? MediaQuery.of(context).size.width * 0.037
                                : MediaQuery.of(context).size.width * 0.045, height: 2.0, fontWeight: FontWeight.w600, color: Color(0xFF3F3F3F)),
            ),
          ),
          SizedBox(height: 10),
          FadeIn(
               3.0,  AutoSizeText(
              body,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (MediaQuery.of(context).size.width> 400 && MediaQuery.of(context).size.width < 420)
                                ? MediaQuery.of(context).size.width * 0.032
                                : MediaQuery.of(context).size.width * 0.037, height: 2.0),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeIn(3.5, Text('by Get Started you are accepting our', style: TextStyle(fontSize: 11,),)),
              SizedBox(width: 3),
              FadeIn(4.0, InkWell(child: Text('T&C', style: TextStyle(color: Color(0xFF5679db), fontSize: 11, fontWeight: FontWeight.bold,),), onTap: ()=> launch('https://covid19-6.flycricket.io/terms.html'),)),
          ],)
        ],
      ),
    );
  }
}

