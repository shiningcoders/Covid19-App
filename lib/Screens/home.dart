//HomePage : Conatains(Country Search Button, Display Banner of World Stats, Map, Donate, Meditate, Water Tracker, HelpLine & Share Button)

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/IconPack/ajayistic_icons_icons.dart';
import 'package:covid19/IconPack/shine_icons.dart';
import 'package:covid19/Screens/Donate.dart';
import 'package:covid19/Screens/Meditation.dart';
import 'package:covid19/Screens/helpline.dart';
import 'package:covid19/Screens/map.dart';
import 'package:covid19/Screens/search.dart';
import 'package:covid19/Widgets/chart_data.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'dart:convert' show json;
import 'package:covid19/Utils/signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covid19/Utils/ListAnimater.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Set Username (inside Disk)
  setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      if (name == null && imageUrl == null) {
        setState(() {
          //_counter = (prefs.getInt('counter') ?? 0) + 1;
          name = (prefs.getString('username'));
          imageUrl = (prefs.getString('userimage'));
        });
      } else {
        await prefs.setString('username', name);
        await prefs.setString('userimage', imageUrl);
      }
    }
  }

  // //ADMOB STUFF
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   keywords: <String>['corona', 'covid19', 'health', 'shopping'],
  //   childDirected: false,
  //   designedForFamilies: false,
  //   gender: MobileAdGender.unknown,
  // );

//BannerAd Implementation
/*
  BannerAd myBanner = BannerAd(
   //Replace the testAdUnitId with an ad unit id from the AdMob dash.
   //https://developers.google.com/admob/android/test-ads
   //https://developers.google.com/admob/ios/test-ads
  adUnitId: banner_adUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
*/

  // InterstitialAd myInterstitial = InterstitialAd(
  //   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  //   // https://developers.google.com/admob/android/test-ads
  //   // https://developers.google.com/admob/ios/test-ads
  //   adUnitId: interstitial_adUnitId,
  //   targetingInfo: targetingInfo,
  //   listener: (MobileAdEvent event) {
  //     print("InterstitialAd event is $event");
  //   },
  // );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isFetching = false;
  Map _allData;
  final List<ChartData> _chartData = [];

  Future<void> _fetchChartData() async {
    print('Fetching');
    if (mounted) {
      if (!_isFetching) {
        setState(() {
          _isFetching = true;
        });
      }

      final response = await http.get('https://corona.lmao.ninja/v2/all');
      print(response.statusCode);
      if (mounted) {
        if (response.statusCode == 200) {
          setState(() {
            _allData = json.decode(response.body);
            _chartData.insert(
                0,
                ChartData(
                    name: 'Cases',
                    amount: json.decode(response.body)['cases'],
                    barColor: charts.ColorUtil.fromDartColor(Colors.blue)));
            _chartData.insert(
                1,
                ChartData(
                    name: 'Recovered',
                    amount: json.decode(response.body)['recovered'],
                    barColor: charts.ColorUtil.fromDartColor(Colors.green)));
            _chartData.insert(
                2,
                ChartData(
                    name: 'Deaths',
                    amount: json.decode(response.body)['deaths'],
                    barColor: charts.ColorUtil.fromDartColor(Colors.red)));
            _isFetching = false;
          });
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Make sure you have internet connection.",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.orange,
              action: SnackBarAction(
                label: 'Try Again',
                onPressed: _fetchChartData,
                textColor: Colors.white,
              ),
            ),
          );
        }
      }
    }
  }

  _timestampToDate(ts) {
    var date = new DateTime.fromMillisecondsSinceEpoch(_allData["updated"]);
    var fd =
        formatDate(date, [MM, " ", d, ", ", yyyy, ", ", HH, ":", nn, " ", am]);
    return fd;
  }

  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Download Covid19 App',
        text:
            'Get updates, feeds, information and more, confirmed by WHO on Covid19 app. Also work on enhancing immunity and mental health by meditation lessons, all in this app. \nDOWNLOAD NOW',
        linkUrl:
            'http://play.google.com/store/apps/details?id=com.shiningcoders.covid19',
        chooserTitle: 'Share Covid19 App');
  }

  @override
  void initState() {
    super.initState();
    setName();
    // _messaging.getToken().then((token) => {print('token: ' + token)});

    _fetchChartData();
  }

  @override
  Widget build(BuildContext context) {
    //Fetch Current Time
    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));

    //Check for Time and Update Greeting
    var greeting = '';
    if (timeNow < 12) {
      greeting = 'Good Morning,';
    } else if ((timeNow >= 12) && (timeNow <= 16)) {
      greeting = 'Good Afternoon,';
    } else {
      greeting = 'Good Evening,';
    }

    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;

    //Scaffold
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2FA),
          body: Stack(
            children: <Widget>[
              //App Bar Backdrop
              PageBack(),

              //Women Image
              WomenImage(),

              //Top Icon Bar & Welcome Text
              Container(
                height: screenWidth * 0.6,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        FadeIn(
                          1.3,
                          IconButton(
                            icon: Icon(
                              Shine.sc_icon,
                              color: Color(0xFFf2f2fa),
                              size: 32,
                            ),
                            tooltip: 'Review',
                            onPressed: () => launch(
                                'http://play.google.com/store/apps/details?id=com.shiningcoders.covid19'),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl!=null?imageUrl:'https://via.placeholder.com/150'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.07),
                    FadeIn(
                      0.8,
                      Row(
                        children: <Widget>[
                          SizedBox(width: 25.0),
                          Text(
                            greeting,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF2F2FA),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    FadeIn(
                      1.1,
                      Row(
                        children: <Widget>[
                          SizedBox(width: 25.0),
                          Text(
                            name != null
                                ? name
                                : 'How are you?', //---------------------------------------------------Name(Fetching) : Firebase
                            style: TextStyle(
                                fontSize: screenWidth * 0.047,
                                color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.06),
                    FadeIn(
                      1.3,
                      Row(
                        children: <Widget>[
                          SizedBox(width: 25.0),
                          Text(
                            //,
                            'Stay home, Stay safe',
                            style: TextStyle(
                                fontSize:
                                    (screenWidth > 400 && screenWidth < 420)
                                        ? screenWidth * 0.032
                                        : screenWidth * 0.037,
                                color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Main Body
              RefreshIndicator(
                backgroundColor: Color(0xFFf2f2fa),
                color: Color(0xFF6f8ee4),
                onRefresh: () => _fetchChartData(),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(height: screenWidth * 0.75),

                    //Main Bottom Sheet
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            topRight: Radius.circular(radius)),
                        color: Color(0xFFF2F2FA),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),

                          //================================================================================
                          //====================================Search Bar===================================
                          //=================================================================================
                          FadeIn(
                            1.5,
                            Hero(
                              tag: 'searchBar',
                              child: GestureDetector(
                                  child: Container(
                                    height: screenWidth * 0.17,
                                    margin: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      color: Color(0xFFD6DCF4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                'Country',
                                                style: TextStyle(
                                                  fontSize:
                                                      (screenWidth > 400 &&
                                                              screenWidth < 420)
                                                          ? screenWidth * 0.04
                                                          : screenWidth * 0.055,
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF5579DB),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          radius),
                                                ),
                                                child: Center(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                        icon: Icon(
                                                          AjayisticIcons
                                                              .a014_search,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: null),
                                                  ),
                                                ),
                                                width: screenWidth * 0.23,
                                                height: screenWidth * 0.17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(_pageJump(SearchPage()));
                                  }),
                            ),
                          ),

                          SizedBox(height: screenWidth * 0.088),

                          FadeIn(
                            1.8,
                            Container(
                              height: screenWidth * 0.23,
                              margin: EdgeInsets.only(left: 25.0, right: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: <Widget>[
                                  //Infected Banner
                                  DisplayBanner(
                                    allData: _allData,
                                    isFetching: _isFetching,
                                    data: 'cases',
                                    title: 'Cases',
                                  ),

                                  SizedBox(width: screenWidth * 0.02),

                                  //Recovered Banner
                                  DisplayBanner(
                                    allData: _allData,
                                    isFetching: _isFetching,
                                    data: 'recovered',
                                    title: 'Recovered',
                                  ),

                                  SizedBox(width: screenWidth * 0.02),

                                  //Deaths Banner
                                  DisplayBanner(
                                    allData: _allData,
                                    isFetching: _isFetching,
                                    data: 'deaths',
                                    title: 'Deaths',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          FadeIn(
                            2.0,
                            Container(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  _isFetching
                                      ? Text('')
                                      : Text(
                                          'updated on ${_timestampToDate(_allData["recovered"])}',
                                          style: TextStyle(
                                            fontSize: (screenWidth > 400 &&
                                                    screenWidth < 420)
                                                ? screenWidth * 0.03
                                                : screenWidth * 0.038,
                                            color: Color(0xFF5579DB),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.088),

                          FadeIn(
                            2.4,
                            DisplayCard(
                              image: 'assets/Map.png',
                              title: 'MAP',
                              pageJump: MapPage(),
                              herotag: 'NOHERO',
                            ),
                          ),

                          SizedBox(height: screenWidth * 0.088),

                          FadeIn(
                            3.4,
                            DisplayCard(
                              image: 'assets/Donate.png',
                              title: 'DONATE',
                              pageJump: Donate(),
                              herotag: 'donateImage',
                            ),
                          ),

                          SizedBox(height: screenWidth * 0.088),

                          FadeIn(
                              3.8,
                              AnimatedCard(
                                animation: 'meditation',
                                pageJump: MeditationPage(),
                                herotag: 'meditation',
                                title: 'MEDITATE',
                              )),

                          //SizedBox(height: screenWidth * 0.088),

                          //FadeIn(4.2, WaterTrackerPage()),

                          SizedBox(height: screenWidth * 0.088),

                          FadeIn(
                            4.4,
                            DisplayCard(
                              image: 'assets/helpline.png',
                              title: 'Helpline',
                              pageJump: Helpline(),
                              herotag: 'helplineImage',
                            ),
                          ),

                          SizedBox(
                            height: screenWidth * 0.066,
                          ),

                          //+++++++++++++++++SHARE+++++++++++++++++++++++++++++++

                          Stack(
                            children: <Widget>[
                              FadeIn(
                                5.0,
                                Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FadeIn(
                                            5.2,
                                            AutoSizeText(
                                              'Help others by Sharing this\nApp',
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: (screenWidth > 400 &&
                                                        screenWidth < 420)
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
                                            5.4,
                                            Text(
                                              'Share this app to your\nfamily, friends and\nevery person you know,\nto aware them regarding\nCOVID-19.',
                                              style: TextStyle(
                                                fontSize: (screenWidth > 400 &&
                                                        screenWidth < 420)
                                                    ? screenWidth * 0.026
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(width: 30),
                                          FadeIn(
                                            5.6,
                                            RawMaterialButton(
                                              elevation: 0,
                                              onPressed: () => share(),
                                              child: Text(
                                                'Share Now',
                                                style: TextStyle(
                                                  fontSize:
                                                      (screenWidth > 400 &&
                                                              screenWidth < 420)
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius))),
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
                                  6.0,
                                  SizedBox(
                                    width: screenWidth * 0.6,
                                    height: screenWidth * 0.6,
                                    child: Image.asset('assets/share.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          SizedBox(height: screenWidth * 0.066),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeIn(
                                7,
                                Text(
                                  'Shining Coders',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF5679db),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.088),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // myInterstitial.dispose();
    //animationController.dispose();
    super.dispose();
  }
}

//--------------------------------------------------------------------------------------------//
//-------------------------------------X DEFINATIONS X----------------------------------------//
//--------------------------------------------------------------------------------------------//

//AppBar Backdrop Defination
class PageBack extends StatefulWidget {
  @override
  _PageBackState createState() => _PageBackState();
}

class _PageBackState extends State<PageBack> {
  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    double diameter = screenWidth * 2.2;

    return Stack(
      children: <Widget>[
        Container(
          child: Positioned(
            top: -(screenWidth * 1.5),
            right: -(screenWidth * 0.58),
            child: Container(
              height: diameter,
              width: diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFFA6BCF8), const Color(0xFF5579DB)],
                  //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//WomenImage Defination
class WomenImage extends StatefulWidget {
  @override
  _WomenImageState createState() => _WomenImageState();
}

class _WomenImageState extends State<WomenImage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));

    var image = '';

    setState(() {
      if (timeNow < 12) {
        image = 'assets/women.png';
      } else if ((timeNow >= 12) && (timeNow <= 16)) {
        image = 'assets/women2.png';
      } else {
        image = 'assets/women3.png';
      }
    });

    return Positioned(
      top: screenWidth * 0.25,
      right: screenWidth * 0,
      child: FadeIn(
        0.5,
        Container(
          width: screenWidth * 0.58,
          height: screenWidth * 0.58,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayBanner extends StatelessWidget {
  DisplayBanner({
    @required this.allData,
    @required this.isFetching,
    @required this.data,
    @required this.title,
  });
  var isFetching;
  var allData;
  var data;
  var title;
  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF5579DB),
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFFD6DCF4),
                      fontSize: (screenWidth > 400 && screenWidth < 420)
                          ? screenWidth * 0.03
                          : screenWidth * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isFetching
                      ? Text(
                          '---',
                          style: TextStyle(
                              color: Color(0xFFF2F2FA),
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        )
                      : AutoSizeText(
                          allData[data].toString(),
                          maxLines: 1,
                          style: TextStyle(
                              color: Color(0xFFF2F2FA),
                              fontSize: (screenWidth > 400 && screenWidth < 420)
                                  ? screenWidth * 0.04
                                  : screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayCard extends StatelessWidget {
  DisplayCard({
    @required this.image,
    @required this.title,
    @required this.pageJump,
    @required this.herotag,
  });

  Widget pageJump;
  String image;
  String title;
  String herotag;

  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_pageJump(pageJump));
      },
      child: Container(
        height: screenWidth * 0.5,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Color(0xFFD6DCF4),
                ),
                child: Hero(
                  tag: herotag,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(10)),
                    color: Color(0x995679DB),
                  ),
                  child: Center(
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                        //color: Color(0xFF01143F),
                        color: Color(0xFF3b3b3b),
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

class AnimatedCard extends StatelessWidget {
  AnimatedCard({
    @required this.title,
    @required this.animation,
    @required this.pageJump,
    @required this.herotag,
  });

  String title;
  Widget pageJump;
  String animation;
  String herotag;

  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_pageJump(pageJump));
      },
      child: Container(
        height: screenWidth * 0.7,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Color(0xFFD6DCF4),
                ),
                child: Hero(
                  tag: herotag,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: FlareActor("assets/${animation}.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        animation: "Float"),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(10)),
                    color: Color(0x995679DB),
                  ),
                  child: Center(
                    child: Text(
                      title,
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
