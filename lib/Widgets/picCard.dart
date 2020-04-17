import 'package:flutter/material.dart';

class PicCard extends StatelessWidget {
  PicCard({
    this.pic,
    this.title,
  });
  String pic;
  String title;
  @override
  Widget build(BuildContext context) {

    //Relatime ScreenSize
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth*0.07;

    return Container(
      width: screenWidth*0.37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Color(0xFF6F8EE4),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: screenWidth*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              height: screenWidth*0.23,
              width: screenWidth*0.25,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(pic)),
              ),
            ),
            SizedBox(height: screenWidth*0.037),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.038 : screenWidth*0.047 ,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2F2FA),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
