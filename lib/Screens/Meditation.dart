import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/Screens/SoundPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'MediMusic.dart';

typedef void OnError(Exception exception);

class MeditationPage extends StatefulWidget {
  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
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
                      tag: 'meditation',
                      child: Container(
                        height: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FlareActor("assets/meditation.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            animation: "Float"),
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
                        //Widget in Bottom Sheet

                        SizedBox(height: 30),
                        Text(
                          'Meditate Daily',
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
                          'to release stress and stay healthy',
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

                        //Getting Started
                        MeditationCard(
                          authorName: 'César Brasil',
                          authorUrl: 'http://www.cesarbrasil.com',
                          body:
                              'Starting something new is difficult than one we are already doing. But the fruit is really sweet. Inventing something is always hard but makes you stand different among others.\n\nStart exploring into yourself, know your best potential, make most out of yourself by meditating daily.\n\nLet\'s start a new journey.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1jaaPJdhfssmSaRK2YnxKO0xFsZ7qMk1u',
                          image: 'assets/basic.png',
                          url:
                              'https://docs.google.com/uc?export=open&id=11pQ1wIu0wgSZk9qmHUM0p_DQX1gOIFRu',
                          title: 'Getting Started',
                          subTitle: 'let\'s start the journey',
                          duration: '1 min',
                          shortDesc:
                              'There is lot to explore in the world and so in you. Let\'s start exploration.',
                        ),

                        //No Panic
                        MeditationCard(
                          authorName: 'Tara Brach',
                          authorUrl: 'https://www.tarabrach.com',
                          body:
                              'Panic or Fear is just another State of Mind. Let\'s Change it.\n\nMeditation means to heal your mind and healing fearful mind is just another application of meditation.\nJust lose your body, observe the environment and sounds and make your body relaxed.\n\n That\'s it.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1VjZnGJ0TcvWf1DD20g0gSqUsjLgajmq5',
                          image: 'assets/noPanic.png',
                          url:
                              'http://hwcdn.libsyn.com/p/2/5/e/25e7e7172db7989c/2020-03-18-Meditation-for-Times-Pandemic-Awakened-Heart-TaraBrach.mp3?c_id=67591688&cs_id=67591688&expiration=1586727556&hwt=10ac7cec87129427a340b86673b995e4',
                          title: 'Turn off Panic',
                          subTitle: 'overcome your internal fear',
                          duration: '23 min',
                          shortDesc:
                              'Panic is just another State of Mind. Meditate to change it.',
                        ),

                        //Body Scan
                        MeditationCard(
                          authorName: 'Tara Brach',
                          authorUrl: 'https://www.tarabrach.com',
                          body:
                              'Body scan meditation is a good way to release tension you might not even realize you\'re experiencing. Body scanning involves paying attention to parts of the body and bodily sensations in a gradual sequence from feet to head.\n\nStart sensing your internal body.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1VjZnGJ0TcvWf1DD20g0gSqUsjLgajmq5',
                          image: 'assets/medilines.png',
                          url:
                              'https://hwcdn.libsyn.com/p/8/5/6/856a28f0ce8c9310/2015-02-18-Meditation-Body-Scan-Living-Presence-11min-TaraBrach.mp3?c_id=8405335&cs_id=8405335&expiration=1586550088&hwt=b835053a92c0a07d8fc0228ff117084e',
                          title: 'Body Scan',
                          subTitle: 'let brain, scan through your body',
                          duration: '11 min',
                          shortDesc:
                              'Scan through your body internally, by your own.',
                        ),

                        //Serenity
                        MeditationCard(
                          authorName: 'Self Improve Co.',
                          authorUrl: 'https://www.selfimprove.co',
                          body:
                              'Every emotion, every feeling is our own creation. But only some of us know to use it in a controlled way. We create these emotions and then we fall in them.\n\nFind how to create these in correct way, and fill our lives with love, calmness and happiness.\n\nLet\'s find what we deserves.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=106K4C7HTNcfh2MNY79r2NoNIFcSuWDHM',
                          image: 'assets/medistar.png',
                          url:
                              'https://docs.google.com/uc?export=open&id=1QVZGEKClWksjuOULN_x5ZcCvp3MzAlXU',
                          title: 'Serenity',
                          subTitle: 'find happy you',
                          duration: '3 min',
                          shortDesc:
                              'Find a lovely, calmful, peaceful and less troubled soul in you. Fill your life with happiness and joy.',
                        ),

                        //Loving this life
                        MeditationCard(
                          authorName: 'Tara Brach',
                          authorUrl: 'https://www.tarabrach.com',
                          body:
                              'Our life is so perfect that if a single thing wouldn\'t be there, we can\'t exist. Everything is so balanced. But still, we use to complain about our lives, which we are handling by own.\n\nFor getting something big out of this life, we have to love this life, as what we get is the result of what we give.\nStart loving your life.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1VjZnGJ0TcvWf1DD20g0gSqUsjLgajmq5',
                          image: 'assets/medibubble.png',
                          url:
                              'http://www.tarabrach.com/audio/2011-04-13-Metta-Meditation--Happiness-17min-TaraBrach-hq.mp3',
                          title: 'Loving This Life',
                          subTitle: 'give love to get love',
                          duration: '16 min',
                          shortDesc:
                              'This life is awesome, just you have to recognise. Love this life, to get love from it.',
                        ),

                        //Relax Into Happiness
                        MeditationCard(
                          authorName: 'Tara Brach',
                          authorUrl: 'https://www.tarabrach.com',
                          body:
                              'Lama Gendun Rinpoche writes, “Happiness cannot be found through great effort and willpower, but it is already there, in relaxation and letting go.” This meditation turns us toward this naturally arising happiness by awakening awareness through the body, and then practicing “relaxing back,” over and over, into the aliveness and presence that is always here.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1VjZnGJ0TcvWf1DD20g0gSqUsjLgajmq5',
                          image: 'assets/medihexa.png',
                          url:
                              'http://hwcdn.libsyn.com/p/2/1/8/2187b002c12ff676/2017-11-22-Meditation-Relax-into-Happiness-TaraBrach.mp3?c_id=17896708&cs_id=17896708&expiration=1586791519&hwt=f3f758c896035c1a2bbd54b48e202f8c',
                          title: 'Relax Into Happiness',
                          subTitle: 'let\'s make a happy cell',
                          duration: '19 min',
                          shortDesc:
                              'Happiness is a tool to improve efficiency. Happy you, happy life.',
                        ),

                        //Facing Bad Days
                        MeditationCard(
                          authorName: 'Mindful Pause',
                          authorUrl: 'https://www.theanxiouslawyer.com',
                          body:
                              'Good and Bad days are part of our life. Nothing is static in this world, everything changes with time and so our bad days. But feeling a day is bad is our creation of mind, we can change it. For that we just need to balance our state of mind and it\'s not any tough, all you have to do is being regular about meditation.\n\nLet\'s make it good.',
                          dpUrl:
                              'https://docs.google.com/uc?export=open&id=1WI3apWn6R4kVUwTSXz26nUVn80rWGj8n',
                          image: 'assets/mediplus.png',
                          url:
                              'https://docs.google.com/uc?export=open&id=1KQhvE0y5UVyrerO0gNsRPSeOe60GoHJe',
                          title: 'Facing Bad Days',
                          subTitle: 'says you are mentally strong',
                          duration: '7 min',
                          shortDesc:
                              'Bad days come and go, what should remains static is your state of mind.',
                        ),

                       // SizedBox(height: 20),

                      //  MusicCardsDisplay(),

                        SizedBox(height: 30),
                        Divider(
                          color: Color(0x77D6DCF4),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: AutoSizeText(
                            'Tip: Long Press any card to see description',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: (screenWidth > 400 && screenWidth < 415)
                                  ? screenWidth * 0.038
                                  : screenWidth * 0.047,
                              color: Color(0xFFF2F2F9),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}

class MeditationCard extends StatefulWidget {
  MeditationCard({
    @required this.image,
    @required this.url,
    @required this.title,
    @required this.subTitle,
    @required this.authorName,
    @required this.authorUrl,
    @required this.body,
    @required this.dpUrl,
    @required this.duration,
    @required this.shortDesc,
  });
  String image;
  String url;
  String title;
  String subTitle;
  String body;
  String dpUrl;
  String authorName;
  String authorUrl;
  String duration;
  String shortDesc;
  @override
  _MeditationCardState createState() => _MeditationCardState();
}

class _MeditationCardState extends State<MeditationCard> {
  Duration _myDuration = Duration(milliseconds: 400);
  Duration _myDuration1 = Duration(milliseconds: 1000);
  double height;
  bool _pressedOnce = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        _pressedOnce = false;
        height = 0.55;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onLongPress: () {
        setState(() {
          _pressedOnce = !_pressedOnce;
          _pressedOnce ? height = 0.88 : height = 0.55;
        });
      },
      onTap: () {
        Navigator.of(context).push(_pageJump(SoundPlayer(
          authorName: widget.authorName,
          authorUrl: widget.authorUrl,
          body: widget.body,
          dpUrl: widget.dpUrl,
          subTitle: widget.subTitle,
          title: widget.title,
          url: widget.url,
        )));
      },
      child: AnimatedContainer(
        duration: _myDuration,
        curve: Curves.easeIn,
        height: screenWidth * height,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.07),
          color: _pressedOnce ? Color(0xFFf2f2fa) : Color(0xFFf2f2fa),
          //color: Color(0xFFf2f2fa),
          image: DecorationImage(
              image: AssetImage(widget.image), fit: BoxFit.cover),
        ),
        child: AnimatedContainer(
            duration: _myDuration1,
            curve: Curves.bounceIn,
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      '${widget.title}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: _pressedOnce
                            ? screenWidth * 0.08
                            : screenWidth * 0.08,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        _pressedOnce ? screenWidth * 0.05 : screenWidth * 0.03),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _pressedOnce
                          ? Flexible(
                              child: AutoSizeText(
                              '${widget.shortDesc}',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _pressedOnce
                                      ? screenWidth * 0.04
                                      : screenWidth * 0.00,
                                  fontWeight: FontWeight.w400),
                            ))
                          : Text(
                              '${widget.duration}',
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                )
              ],
            )),
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

class MusicCardsDisplay extends StatefulWidget {
  @override
  _MusicCardsDisplayState createState() => _MusicCardsDisplayState();
}

class _MusicCardsDisplayState extends State<MusicCardsDisplay> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth * 0.7,
      child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
                width: screenWidth * 0.5,
                height: screenWidth * 0.55,
                child: Center(
                    child: Text(
                  'Medi Music >',
                  style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFf2f2fa)),
                ))),
            MusicCard(
                image: 'assets/medihexa.png',
                url: null,
                title: 'Study',
                ),
            MusicCard(
                image: 'assets/basic.png',
                url: null,
                title: 'Sleep',
                ),
            MusicCard(
                image: 'assets/medistar.png',
                url: null,
                title: 'Binaural',
                ),
            MusicCard(
                image: 'assets/medilines.png',
                url: null,
                title: '',
                ),
          ]),
    );
  }
}

class MusicCard extends StatefulWidget {
  MusicCard({
    @required this.image,
    @required this.url,
    @required this.title,
  });
  String image;
  String url;
  String title;
  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  double width;
  bool _pressedOnce;
  Duration _myDuration = Duration(milliseconds: 400);
  Duration _myDuration1 = Duration(milliseconds: 1000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        _pressedOnce = false;
        width = 0.55;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onLongPress: () {
        setState(() {
          _pressedOnce = !_pressedOnce;
          _pressedOnce ? width = 0.8 : width = 0.55;
        });
      },
      onTap: () {
        Navigator.of(context).push(_pageJump(MusicPlayer(
          url: widget.url,
        )));
      },
      child: AnimatedContainer(
        duration: _myDuration,
        curve: Curves.easeIn,
        height: screenWidth * 0.55,
        width: screenWidth * width,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.07),
          color: _pressedOnce ? Color(0xFFf2f2fa) : Color(0xFFf2f2fa),
          //color: Color(0xFFf2f2fa),
          image: DecorationImage(
              image: AssetImage(widget.image), fit: BoxFit.cover),
        ),
        child: AnimatedContainer(
            duration: _myDuration1,
            curve: Curves.bounceIn,
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.title}',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: _pressedOnce
                            ? screenWidth * 0.1
                            : screenWidth * 0.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
