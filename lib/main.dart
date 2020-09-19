import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subunit/UI/decoration.dart';
import 'package:subunit/authorize.dart';
import 'package:subunit/home.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubUnit Inventory',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseUser currentUser;
  String unitNumber = '';

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance
        .currentUser()
        .then((cu) => {currentUser = cu})
        .catchError((err) => print(err));

    print(currentUser);

    _getUnitInfoFromSharedPref().then((unit) {
      setState(() {
        unitNumber = unit;
      });
    });
    print('Unit - ' + unitNumber);
    
    super.initState();
  }

  Future<String> _getUnitInfoFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String unitNumber = prefs.getString('CurrentUnit');
    return unitNumber;
  }

  @override
  Widget build(BuildContext context) {
    
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              currentUser == null ? LoginPage() : HomePage(unitNumber),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.1,
                  child: Image.asset(
                    'assets/images/splash_.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3.5,
                  left: (MediaQuery.of(context).size.width - 90) / 2,
                  child: Image.asset(
                    'assets/images/blackloader2.gif',
                    height: 90,
                    width: 90,
                  ),
                ),
                WavyHeaderImage(
                  color1: Color(0xffFF7979),
                  color2: Color(0xffFF7979),
                  color3: Colors.black54,
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 140,
                    speed: 0.8,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 80,
                    speed: 0.8,
                    offset: pi,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedWave(
                    height: 180,
                    speed: 0.8,
                    offset: pi / 2,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
