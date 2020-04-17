//Redirects to linkes of websites (for donation)

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/IconPack/glinticons_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpline extends StatefulWidget {
  @override
  _HelplineState createState() => _HelplineState();
}

class _HelplineState extends State<Helpline> {
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
                    SizedBox(
                      height: screenWidth * 0.05,
                    ),
                    Hero(
                      tag: 'helplineImage',
                                        child: Container(
                        height: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage('assets/helpline.png'),
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
                  SizedBox(height: screenWidth * 0.68),
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
                          'Helpline',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (screenWidth > 400 && screenWidth < 415)
                                ? screenWidth * 0.05
                                : screenWidth * 0.06,
                            color: Color(0xFFF2F2F9),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Always there for you',
                          style: TextStyle(
                            fontSize: (screenWidth > 400 && screenWidth < 415)
                                ? screenWidth * 0.038
                                : screenWidth * 0.047,
                            color: Color(0xFFF2F2F9),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Color(0x77D6DCF4),
                        ),

                        SizedBox(height: 20),
                        HelplineCard(
                          title: 'WHO',
                          subTitle: 'World Health Organization',
                          website: 'https://www.who.int/',
                          phoneNo: 'tel:+41-22-7912111',
                          whatsapp:
                              'https://api.whatsapp.com/send?phone=41225017615&text=hi&source=&data=',
                        ),
                        HelplineCard(
                          title: 'Ministry of Health & Family Welfare',
                          subTitle: 'Govt. of India',
                          phoneNo: 'tel:+91-11-23978046',
                          website: 'https://www.mohfw.gov.in/',
                          whatsapp:
                              'https://api.whatsapp.com/send?phone=919013151515&text=Namaste&source=&data=',
                        ),
                        HelplineCard(
                            title: 'Centers for Disease Control & Prevention',
                            subTitle: 'Govt. of America',
                            website: 'https://www.cdc.gov/coronavirus/2019-nCoV/index.html',
                            whatsapp: 'https://api.whatsapp.com/send?phone=41798931892&text=hi&source=&data=',
                            phoneNo: 'tel:800-232-4636'),
                        HelplineCard(
                            title: 'Ministry of Health',
                            subTitle: 'Govt. of Italy',
                            website: 'http://www.salute.gov.it/nuovocoronavirus',
                            whatsapp: 'https://api.whatsapp.com/send?phone=41798931892&text=hi&source=&data=',
                            phoneNo: 'tel:1500'),

                        SizedBox(height: 20),
                        Divider(
                          color: Color(0x77D6DCF4),
                        ),
                        AutoSizeText(
                          'Get your symptoms observed',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: (screenWidth > 400 && screenWidth < 415)
                                ? screenWidth * 0.038
                                : screenWidth * 0.047,
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

class HelplineCard extends StatelessWidget {
  HelplineCard({
    @required this.title,
    @required this.subTitle,
    @required this.website,
    @required this.whatsapp,
    @required this.phoneNo,
  });

  String title, subTitle, website, whatsapp, phoneNo;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(20),
      height: width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.07),
        color: Color(0xFFd6dcf4),
      ),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AutoSizeText(
              title,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    (width > 400 && width < 415) ? width * 0.05 : width * 0.06,
                color: Color(0xFF3b3b3b),
              ),
            ),
            AutoSizeText(
              subTitle,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    (width > 400 && width < 415) ? width * 0.02 : width * 0.03,
                color: Color(0x993b3b3b),
              ),
            ),
            Divider(
              color: Color(0x993b3b3b),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Glinticons.a018_outgoing_call,
                      color: Color(0xFF5679db),
                      size: (width > 400 && width < 415)
                          ? width * 0.06
                          : width * 0.07,
                    ),
                    onPressed: () => launch(phoneNo)),
                IconButton(
                    icon: Icon(
                      Glinticons.a015_safari,
                      color: Color(0xFF5679db),
                      size: (width > 400 && width < 415)
                          ? width * 0.06
                          : width * 0.07,
                    ),
                    onPressed: () => launch(website, forceWebView: true)),
                IconButton(
                    icon: Icon(
                      Glinticons.a017_whatsapp,
                      color: Color(0xFF5679db),
                      size: (width > 400 && width < 415)
                          ? width * 0.06
                          : width * 0.07,
                    ),
                    onPressed: () => launch(whatsapp, forceWebView: true)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
