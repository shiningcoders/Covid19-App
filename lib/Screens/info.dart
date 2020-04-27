//______________ _ _ Info Page _ _ ___________________

import 'package:covid19/IconPack/ajayistic_icons_icons.dart';
import 'package:covid19/IconPack/glinticons_icons.dart';
import 'package:covid19/Screens/onboarding_page.dart';
import 'chatbot.dart';
import 'package:covid19/Utils/ListAnimater.dart';
import 'package:covid19/Utils/signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:covid19/Widgets/picCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   keywords: <String>['corona', 'covid19', 'health', 'shopping'],
  //   childDirected: false,
  //   designedForFamilies: false,
  //   gender: MobileAdGender.unknown,
  // );

  // InterstitialAd myInterstitial = InterstitialAd(
  //   adUnitId: interstitial_adUnitId,
  //   targetingInfo: targetingInfo,
  //   listener: (MobileAdEvent event) {
  //     print("InterstitialAd event is $event");
  //   },
  // );

  @override
  void initState() {
    // myInterstitial
    //   ..load()
    //   ..show(
    //     anchorType: AnchorType.bottom,
    //     anchorOffset: 0.0,
    //     horizontalCenterOffset: 0.0,
    //   );
    super.initState();
  }

  @override
  void dispose() {
   // myInterstitial.dispose();
    super.dispose();
  }

  
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Download Covid19 App',
        text:
            'Get updates, feeds, information and more, confirmed by WHO on Covid19 app. Also work on enhancing immunity and mental health by meditation lessons and keep track of hydration level of your body, all in this app. \nDOWNLOAD NOW',
        linkUrl:
            'http://play.google.com/store/apps/details?id=com.shiningcoders.covid19',
        chooserTitle: 'Share Covid19 App');
  }

  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final radius = screenWidth * 0.07;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
              child: Scaffold(
          backgroundColor: Color(0xFF5679db),
          body: Stack(
            children: <Widget>[
              //__________________________________________________
              //_________________Top Bar__________________________
              //__________________________________________________
              Column(
                children: <Widget>[
                  Container(
                    height: 100, // height specifier
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 30),
                            FadeIn(
                                 1.0, Text(
                                name != null ? '$name,' : 'Dear,',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF2F2FA),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth*0.02),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 30),
                            FadeIn(
                                  1.3, Text(
                                'Get Informed about COVID-19',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Color(0xFFF2F2FA),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //Feature Button_______________________________________________________________
              Positioned(
                top: 20,
                right: 30,
                child: FadeIn(
                         1.6, FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Color(0xFFD6DCF4),
                    //child: Icon(
                    //  AjayisticIcons.a008_graphic_designer,
                    //  color: Color(0xFF5679db),
                    //),
                    child: imageUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                            radius: 200.0,
                            foregroundColor: Color(0xffd6dcf4),
                          )
                        : Icon(AjayisticIcons.a013_user, color: Color(0xFF5679db)),
                    onPressed: null,
                  ),
                ),
              ),
              //============================================================================================
              //________________________________________Bottom Sheet________________________________________
              //============================================================================================

              ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 95),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            topRight: Radius.circular(radius)),
                        color: Color(0xFFf2f2fa),
                      ),
                      child: Column(
                        children: <Widget>[
                          //=========================================================
                          //_______________Widgets in Bottom Sheet____________________
                          //==========================================================

                          SizedBox(height: screenWidth * 0.088),
                          //Main Widget--------------------------------
                          Stack(
                            children: <Widget>[
                              FadeIn(
                                    2.0, Container(
                                  height: screenWidth * 0.7,
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFd6dcf4),
                                    borderRadius: BorderRadius.circular(radius),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          FadeIn(
                                                2.2, Text(
                                              'Avoid the Scare of COVID-19',
                                              style: TextStyle(
                                                fontSize: (screenWidth > 400 && screenWidth < 420)
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.055,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xFF5679db),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 30),
                                          FadeIn(
                                                2.4, Text(
                                              'Don\'t panic or stress,\nbut also don\'t\n ignore Symptoms.\nGet you symptoms\nobserved today.',
                                              style: TextStyle(
                                                fontSize: (screenWidth > 400 && screenWidth < 420)
                                  ? screenWidth * 0.025
                                  : screenWidth * 0.03,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(width: 30),
                                          FadeIn(
                                                2.6, RawMaterialButton(
                                                  elevation: 0,
                                              onPressed: () => launch('https://www.apple.com/covid19',),
                                              child: Text(
                                                'Consult Now',
                                                style: TextStyle(
                                                  fontSize: (screenWidth > 400 && screenWidth < 420)
                                  ? screenWidth * 0.036
                                  : screenWidth * 0.04,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xFFf2f2fa),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 12),
                                              fillColor: Color(0xFF5679db),
                                              splashColor: Color(0xFF6f8ee4),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(radius))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 5,
                                child: FadeIn(
                                              3.0, SizedBox(
                                    width: screenWidth * 0.55,
                                    height: screenWidth * 0.55,
                                    child: Image.asset('assets/stressed.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeIn(
                                    3.2, Text(
                                  'Symptoms',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.057,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.07),

                          Container(
                            height: screenWidth * 0.5,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(width: 20),
                                FadeIn(
                                      3.5, PicCard(
                                      pic: 'assets/Cards/Symp1.png',
                                      title: 'High Fever'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      3.6, PicCard(
                                      pic: 'assets/Cards/Symp2.png',
                                      title: 'Sore Throat'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      3.7, PicCard(
                                      pic: 'assets/Cards/Symp3.png',
                                      title: 'Cough &\n Sneeze'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      3.8, PicCard(
                                      pic: 'assets/Cards/Symp4.png',
                                      title: 'Headache'),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.088),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeIn(
                                    4.0, Text(
                                  'Contagion',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.057,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.07),
                          Container(
                            height: screenWidth * 0.5,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(width: 20),
                                FadeIn(
                                     4.3, PicCard(
                                      pic: 'assets/Cards/Cont1.png',
                                      title: 'Personal\nContact'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      4.4, PicCard(
                                      pic: 'assets/Cards/Cont2.png',
                                      title: 'Air by Cough\n or Sneeze'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      4.5, PicCard(
                                      pic: 'assets/Cards/Cont3.png',
                                      title: 'Contact\nwith Animal'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      4.6, PicCard(
                                      pic: 'assets/Cards/Cont4.png',
                                      title: 'Contaminated\nObject'),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.088),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeIn(
                                    4.8, Text(
                                  'Prevention',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.057,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.07),
                          Container(
                            height: screenWidth * 0.5,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(width: 20),
                                FadeIn(
                                      5.0, PicCard(
                                      pic: 'assets/Cards/Prev1.png',
                                      title: 'Wash Hands'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      5.1, PicCard(
                                      pic: 'assets/Cards/Prev2.png',
                                      title: 'Use Mask'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                      5.2, PicCard(
                                      pic: 'assets/Cards/Prev4.png',
                                      title: 'Avoid Contact\nwith Animal'),
                                ),
                                SizedBox(width: 20),
                                FadeIn(
                                     5.3, PicCard(
                                      pic: 'assets/Cards/Prev3.png',
                                      title: 'Go to\nDoctor'),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.07),
                          GestureDetector(
                            child: FadeIn(
                                5.5, Container(
                                height: screenWidth * 0.9,
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xFFd6dcf4),
                                  borderRadius: BorderRadius.circular(radius),
                                  image: DecorationImage(
                                    image: AssetImage('assets/washHands.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () => launch(
                              'https://www.who.int/gpsc/clean_hands_protection/en/',
                              forceWebView: true,
                            ),
                          ),
                          FadeIn(
                                5.7, Container(
                              height: screenWidth * 0.9,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFd6dcf4),
                                borderRadius: BorderRadius.circular(radius),
                                image: DecorationImage(
                                  image: AssetImage('assets/preventions.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          FadeIn(
                               5.9, Container(
                              height: screenWidth * 0.6,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFd6dcf4),
                                borderRadius: BorderRadius.circular(radius),
                                image: DecorationImage(
                                  image: AssetImage('assets/helpBy5.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          
                          SizedBox(height: screenWidth * 0.07),

                          //Chatbot Widget
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(_pageJump(Chatbot()));
                            },
                      child: FadeIn(
                                    6.0 , Container(
                                                 margin: EdgeInsets.symmetric(horizontal: 20),
                                height: screenWidth*0.3,
                                decoration: BoxDecoration(
                                  color: Color(0xFFd6dcf4),
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Have any question?', style: TextStyle(color: Color(0xFF707070), fontWeight: FontWeight.bold, fontSize: screenWidth*0.06),),
                                        SizedBox(height: 10,),
                                        Text('Ask here', style: TextStyle(color: Color(0xFF5679db), fontWeight: FontWeight.bold, fontSize: screenWidth*0.04),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                          ),

                          SizedBox(height: screenWidth * 0.05),
                          //=================================================================================
                          //=========================Footer==================================================
                          //=================================================================================
                          SizedBox(height: 10),
                          Container(
                            height: screenWidth*0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radius),
                                  topRight: Radius.circular(radius)),
                              color: Color(0xFF5679db),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    //========================REVIEW====================================
                                    RawMaterialButton(
                                      onPressed: () => launch(
                                          'http://play.google.com/store/apps/details?id=com.shiningcoders.covid19'),
                                      child: Text(
                                        'Review',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFd6dcf4),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 12),
                                      fillColor: Color(0xFF6f8ee4),
                                      elevation: 0,
                                      splashColor: Color(0xFF6f8ee4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(radius))),
                                    ),
                                    //==============================SIGN OUT=========================================
                                    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                    RawMaterialButton(
                                      onPressed: () {
                                        signOutGoogle();
                                        Navigator.of(context).push(_pageJump(OnboardingPage()));
                                      } ,
                                      child: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF6f8ee4),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 12),
                                      fillColor: Color(0xFFd6dcf4),
                                      splashColor: Color(0xFF6f8ee4),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(radius))),
                                    ),
                                    //=============================SHARE====================================================
                                    RawMaterialButton(
                                      onPressed: () => share(),
                                      elevation: 0,
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFd6dcf4),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 12),
                                      fillColor: Color(0xFF6f8ee4),
                                      splashColor: Color(0xFF6f8ee4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(radius))),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                //========================================================
                                //======================Social============================
                                //========================================================
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    //==================Instagram====================
                                    IconButton(
                                      icon: Icon(
                                        Glinticons.a019_instagram,
                                        color: Color(0x99f2f2fa),
                                      ),
                                      onPressed: () => launch('https://www.instagram.com/shining_coders'),
                                    ),
                                    //================Mail===========================
                                    IconButton(
                                      icon: Icon(
                                        Glinticons.a009_email,
                                        color: Color(0x99f2f2fa),
                                      ),
                                      onPressed: () => launch('mailto:shiningcoders@gmail.com?subject=${name} from Covid19 App&body=Hey there,\n\nThere is something to tell you about this App.\n'),
                                    ),
                                    //==================Landing Page========================
                                    IconButton(
                                      icon: Icon(
                                        Glinticons.a015_safari,
                                        color: Color(0x99f2f2fa),
                                      ),
                                      onPressed: () => launch('https://covid19-6.flycricket.io/index.html'),
                                    ),
                                    //======================Ko-fi==========================
                                    IconButton(
                                      icon: Icon(
                                        Glinticons.a023_cafe,
                                        color: Color(0x99f2f2fa),
                                      ),
                                      onPressed: () => launch('https://ko-fi.com/shiningcoders'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                //=====================Terms & Conditon || Privacy Policy====================
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(width: 10.0),
                                    InkWell(
                                      child: Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFd6dcf4),
                                        ),
                                      ),
                                      onTap: () => launch(
                                          'https://covid19-6.flycricket.io/terms.html'),
                                    ),
                                    Text(
                                      ' | ',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFFd6dcf4),
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFd6dcf4),
                                        ),
                                      ),
                                      onTap: () => launch(
                                          'https://covid19-6.flycricket.io/privacy.html'),
                                    ),
                                    SizedBox(width: 10.0),
                                  ],
                                ),
                                SizedBox(height:15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                  Text('Shining Coders',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFFd6dcf4),
                                      ),)
                                ],),
                                SizedBox(height:15),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
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