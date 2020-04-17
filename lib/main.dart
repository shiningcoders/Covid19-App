import 'package:covid19/App/app.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/onboarding_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      theme: ThemeData(
        
         primaryColor: Color.fromARGB(255, 242, 242, 250),
        highlightColor: Color.fromARGB(255, 86, 121, 219),
    textTheme: GoogleFonts.quicksandTextTheme(
      Theme.of(context).textTheme,
    ),
  ),
      debugShowCheckedModeBanner: false,
      home: CheckScreen(),
    );
  }
}

//Check Screen checks for user already signed in or not,
//if users signed redired to home otherwise onboarding_screen

class CheckScreen extends StatefulWidget {
  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool LoggedIn=false;
  @override
  void initState() {
    super.initState();
    setScreenRoute();
  }
  void setScreenRoute () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      LoggedIn = prefs.getBool('isUserSigned') != null ? prefs.getBool('isUserSigned') : false;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Animated Splash Screen
    return SplashScreen(
        'assets/splash.flr',
        LoggedIn ? MainPage() : OnboardingPage(),
        startAnimation: 'Intro',
        backgroundColor: Color(0xFFf2f2fa),
      );
  }
}