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
  String location;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
   

    //print(currentUser.phoneNumber);
    //fun1();

  }
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    print(currentUser);
  }

  void fun1()
  {
    switch (currentUser.phoneNumber) {
                                  case "+911212121212":
                                    
                                     {
                                      unitNumber = 's1';
                                      location='Baramati';
                                    }
                                  
                                    break;

                                  case "+911313131313":
                                    
                                    {
                                      unitNumber = 's2';
                                     location='Bhigwan';

                                    }
                                   
                                    break;

                                  case "+911414141414":
                                   
                                   {
                                      unitNumber = 's3';
                                      location='Wathar Station';
                                    }
                                    break;

                                  case "+911515151515":
                                    {
                                     
                                      {
                                      unitNumber = 's4';
                                      location='Koregaon';
                                    }
                                   
                                    }
                                    break;

                                  case '+911616161616':
                                   
                                    {
                                      unitNumber = 's5';
                                     location='Dahiwadi';
                                    }
                                   
                                    break;

                                  case '+911717171717':
                                   
                                     {
                                      unitNumber = 's6';
                                     location='Shirwal';
                                    }
                                   
                                    break;

                                    case '+911818181818':
                                    
                                     {
                                      unitNumber = 's7';
                                     location='SubUnit7';
                                    }
                                   
                                    break;

                                    case '+911919191919':
                                   
                                     {
                                      unitNumber = 's8';
                                    location='SubUnit8';
                                    }
                                    
                                    break;
                                  default:
                                    {
                                      print("Invalid choice");
                                    }
                                    break;
                                }
  }

  

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 2),
      () 
       {
         if(currentUser!=null)
         { 
          fun1();
          }
         Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>

              currentUser == null ? LoginPage() : HomePage(id:unitNumber,loc: location,),
        ),
      );}
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
                  color1: Color(0xff57c89f),
                  color2: Color(0xff57c89f),
                  color3: Color(0xff8df0a9),
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
