
import 'package:covid19/IconPack/ajayistic_icons_icons.dart';
import 'package:covid19/Screens/chatbot.dart';
import 'package:covid19/Screens/feeds.dart';
import 'package:covid19/Screens/home.dart';
import 'package:covid19/Screens/info.dart';
import 'package:covid19/Screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      (MediaQuery.of(context).size.width) * 0.07)),
              elevation: 0.0,
              backgroundColor: Color(0xfff2f2fa),
              title: Text('Do you want to exit?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  )),
              actions: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      (MediaQuery.of(context).size.width) * 0.04)),
                  color: Color(0xFF5679db),
                      child: Text('NO',
                          style: TextStyle(
                            color: Color(0xFFf2f2fa),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                      child: Text(
                        'YES',
                        style: TextStyle(
                          color: Color(0xffe27f79),
                          fontSize: 16.0,
                        ),
                      ),
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ));
  }



int _pageindex = 0;

//Linked Pages with Bottom Navigation Bar
final tabs = [
  HomePage(),
  MapPage(),
  FeedsPage(),
  InfoPage(),
];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: _onBackPressed,
    child: SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
              child: Scaffold(
          backgroundColor: Color(0xFFf2f2fa),

          //Bottom Navigation Bar
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
            ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Color(0xFFF2F2FA),
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              currentIndex: _pageindex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Color(0xFF5579DB),

              items: [
                BottomNavigationBarItem(icon: Icon(AjayisticIcons.a004_front_view), title: Text('Home'),),
                BottomNavigationBarItem(icon: Icon(AjayisticIcons.a006_colours), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(AjayisticIcons.a012_gantt_chart), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(AjayisticIcons.a015_presentation), title: Text('Home')),
              ],
              onTap: (index)
              {
                setState(() {
                  _pageindex = index;
                });
              },
            ),
                      ),
          ),

          //Body: 
          body: tabs[_pageindex],

        ),
      ),
    ),
    );
  }
}
