import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WaterTracker extends StatefulWidget {
  @override
  _WaterTrackerState createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  @override
  Widget build(BuildContext context) {

    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth*0.07;

    return GestureDetector(
      onTap: () {
        //Navigator.of(context).push(_pageJump(Donate()));
        Navigator.of(context).push(_pageJump(null));
      },
          child: Container(
                          height: screenWidth*0.7,
                          child: Container(
                            
                            margin: EdgeInsets.only(left: 20, right: 20),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: Color(0xFFD6DCF4),
                                image: DecorationImage(image: AssetImage('assets/drinking.png'), fit: BoxFit.cover,)
                              ),
                              child: Container(
                              margin: EdgeInsets.all(20.0),
                              
                                ),
                            ),
                            Positioned(
                                  top: 0, left: 0,
                                  child: Container(
                                    width: 210,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), bottomRight: Radius.circular(10)),
                                    color: Color(0x995679DB),
                                    ),
                                    child: Center(
                                      child: AutoSizeText(
                                        'Water Tracker'.toUpperCase(),
                                        maxLines: 1,
                                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                          color: Color(0xFF01143F),
                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
    );
  }
}



Route _pageJump(Widget PageJump) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PageJump,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutExpo;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
