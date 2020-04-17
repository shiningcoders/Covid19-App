import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/Widgets/soundProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:url_launcher/url_launcher.dart';


typedef void OnError(Exception exception);

class SoundPlayer extends StatefulWidget {
  SoundPlayer({ @required this.url,
  @required this.title,
  @required this.subTitle,
  @required this.authorName,
  @required this.authorUrl,
  @required this.body,
  @required this.dpUrl,
  });
  String title;
  String subTitle;
  String url;
  String body;
  String dpUrl;
  String authorName;
  String authorUrl;
  @override
  _SoundPlayerState createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }



  Future<int> _getDuration() async {
    File audiofile = await audioCache.load('audio2.mp3');
    await advancedPlayer.setUrl(
      audiofile.path,
    );
    int duration = await Future.delayed(
        Duration(seconds: 2), () => advancedPlayer.getDuration());
    return duration;
  }

  @override
  Widget build(BuildContext context) {

        var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;


    return MultiProvider(
      providers: [
        StreamProvider<Duration>.value(
            initialData: Duration(),
            value: advancedPlayer.onAudioPositionChanged),
      ],
        child: SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                                      child: Scaffold(
                      backgroundColor: Color(0xFF5679DB),
            body: Stack(
              children: <Widget>[
                ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: screenWidth*0.37),
                      Center(
                          child: PlayerWidget(url: widget.url,),
                      ),
                      SizedBox(height: screenWidth*0.37),

                      //===================================================================
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Color(0xFFf2f2fa),
                    ),


                    //Bottom Sheet ==================================================================================
                    child: Column(
                      children: <Widget>[

                        //-----------------------Header-------------------
                        SizedBox(height: 30),
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.05 : screenWidth*0.06 ,
                            color: Color(0xFF5679db),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${widget.subTitle}',
                          style: TextStyle(
                            fontSize: ( screenWidth > 400 && screenWidth < 415 ) ? screenWidth*0.038 : screenWidth*0.047 ,
                            color: Color(0xFF5679db),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Color(0x775679db),
                        ),
                        SizedBox(height: 20),
                        //===========================================================================================
                        //========================Main Body==========================================================
                        //===========================================================================================
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(child: AutoSizeText('${widget.body}', maxLines: 15, style: TextStyle(fontSize: 20, color: Colors.black87), textAlign: TextAlign.center,)),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(children: <Widget>[
                                Container(margin: EdgeInsets.only(right: 10, left: 10),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF5679DB),
                                  image: DecorationImage(
                                    image: NetworkImage('${widget.dpUrl}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('${widget.authorName}', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    InkWell(onTap: () => launch(widget.authorUrl),child: Text('${widget.authorUrl}', style: TextStyle(color: Color(0xFF5679db)),)),
                                  ],
                                ),
                              ],
                              ),
                            ),
                        ],),
                        SizedBox(height: 20),
                      ],
                    ),
                ),
                    ],
                ),


                //--------------------BACK NAV-------------------------------------------
                //=======================================================================
                Positioned(
              top: 20,
              left: 20,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                ),
                              child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Color(0xFFD6DCF4),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF5679DB),
                      ),
                      onPressed: () => Navigator.pop(context)),
              ),
            ),
              ],
            ),
          ),
                  ),
        ),
    );
  }
}