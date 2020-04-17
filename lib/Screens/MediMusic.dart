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

class MusicPlayer extends StatefulWidget {
  MusicPlayer({ @required this.url});
  String url;
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
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
                Column(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      Center(
                          child: PlayerWidget(url: widget.url,),
                      ),
                      Expanded(child: SizedBox()),

                      //===================================================================

                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Color(0xFFf2f2fa),
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