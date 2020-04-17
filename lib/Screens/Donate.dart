//Redirects to linkes of websites (for donation)

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}


class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
              child: Scaffold(
          backgroundColor: Color(0xFFD6DCF4),
          body: Stack(
            children: <Widget>[
              //_____________________________Backdrop__________________________________
              Container(
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                  SizedBox(height: screenWidth*0.05,),
                    Hero(
                      tag: 'donateImage',
                      child: Container(
                        height: screenWidth*0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage('assets/Donate.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //______________________Bottom Sheet______________________________
              ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: screenWidth*0.68),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Color(0xFF5779DB),
                    ),
                    child: Column(
                      children: <Widget>[


                        //__________________________Widget in Bottom Sheet_________________________

                        SizedBox(height: 30),
                        Text(
                          'Donate',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.05 : screenWidth*0.06 ,
                            color: Color(0xFFF2F2F9),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Help Humans fight COVID-19',
                          style: TextStyle(
                            fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.038 : screenWidth*0.047 ,
                            color: Color(0xFFF2F2F9),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Color(0x77D6DCF4),
                        ),
                        //WHO Card
                        DonationCard(
                          image: 'assets/donateWHO.png',
                          link: 'https://covid19responsefund.org',
                        ),
                        DonationCard(
                          image: 'assets/donatePMcares.png',
                          link: 'https://www.pmindia.gov.in/en/?query#',
                        ),
                        DonationCard(
                          image: 'assets/donateAmericares.png',
                          link: 'https://secure.americares.org/site/Donation2?df_id=24507&mfc_pref=T&24507.donation=form1&_ga=2.87483359.676031364.1585289526-1478265016.1585289526',
                        ),
                        DonationCard(
                          image: 'assets/donateDR.png',
                          link: 'https://www.directrelief.org/emergency/coronavirus-outbreak/',
                        ),

                        SizedBox(height: 20),
                        Divider(
                          color: Color(0x77D6DCF4),
                        ),
                        Text(
                          'Donate directly to official channels',
                          style: TextStyle(
                            fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.038 : screenWidth*0.047 ,
                            color: Color(0xFFF2F2F9),
                          ),
                        ),
                        SizedBox(height: 10),
                        //______________________________________________________________________
                      ],
                    ),
                  ),
                ],
              ),

              //____________________________Back Nav____________________________________________
              Positioned(
                top: 20,
                left: 20,
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Color(0xFF5779DB),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFFD6DCF4),
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
              //_____________________________________________________________________________________
            ],
          ),
        ),
      ),
    );
  }
}


//Donation Card : takes (image to display & link to donation websites)

class DonationCard extends StatelessWidget {
  DonationCard({
    @required this.link,
    @required this.image,
  });
  String link;
  String image;
  @override
  Widget build(BuildContext context) {
    var height = (MediaQuery.of(context).size.width)*0.5;
    return GestureDetector(
      onTap: () => launch(link),
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 15),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFFD6DCF4),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
