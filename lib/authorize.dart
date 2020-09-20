import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subunit/UI/animation.dart';
import 'package:subunit/UI/decoration.dart';

import 'package:subunit/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  // TextEditingController emailInputController;

  // TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController pwdInputController;
  FirebaseUser _firebaseUser;
  String dropdownValue;
  String selectedUnit;

  String _phone;

  Future registerUser(
    String phone,
    BuildContext context,
  ) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) {
          //Navigator.pop(context);
          print('In verificationCompleted');
          FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((result) async {
            print('Uid: ' + result.uid);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(selectedUnit),
              ),
            );
          }).catchError((e) => print(e));
        },
        verificationFailed: (AuthException exception) {
          print('In verificationFailed');
          print(exception.message);
        },
        codeSent: codesent,
        codeAutoRetrievalTimeout: (String verificationId) {
          print('In codeAutoRetrievalTimeout');
          verificationId = verificationId;
          print(verificationId);
          print('TimeOut');
        });
  }

  codesent(String verificationId, [int forceResendingToken]) async {
    print('In codeSent');
    var _credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: _otpController.text.trim());
    FirebaseAuth.instance
        .signInWithCredential(_credential)
        .then((result) async {
      print('Uid:' + result.uid);
      _firebaseUser = result;

      // Navigator.of(context).pop();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(selectedUnit)));
    }).catchError((e) {
      print(e);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Correct Passcode!'),
          );
        },
      );
      Timer(
          Duration(seconds: 1),
          () => {
                Navigator.of(context).pop(),
              });
    });
  }

  @override
  initState() {
    // emailInputController = new TextEditingController();
    _otpController = new TextEditingController();

    super.initState();
  }

  Future<Void> _saveCurrentSubUnit(int unitNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('CurrentUnit', 's$unitNumber');
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login_bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            WavyHeaderImage(
              color1: Color(0xffFF7979),
              color2: Color(0xffFF7979),
              color3: Color(0xffFF7979),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 160,
                speed: 0.8,
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 100,
                speed: 0.8,
                offset: pi,
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 200,
                speed: 0.8,
                offset: pi / 2,
              ),
            ),
            Positioned(
              left: ((w * 0.15) / 2),
              top: h * 0.31,
              // left: -10,
              // top: 200,
              child: FadeAnimation(
                1.0,
                Container(
                  height: h / 2,
                  width: w * 0.85,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      //background color of box
                      BoxShadow(
                        color: Colors.blueGrey[200],
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          10.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      bottomRight: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      bottomLeft: const Radius.circular(40.0),
                      topLeft: const Radius.circular(40.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 55,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              //fontFamily: 'PlayfairDisplay',
                              // color: Color(0xff57c89f),
                              color: Colors.black54,
                              fontSize: 34,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 48,
                          width: w * 0.7,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[400])),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              //dropdownColor: Colors.black,
                              hint: dropdownValue == null
                                  ? Text('Select Unit')
                                  : Text(
                                      dropdownValue,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                              value: dropdownValue,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'SubUnit1',
                                'SubUnit2',
                                'SubUnit3',
                                'SubUnit4',
                                'SubUnit5',
                                'SubUnit6',
                                'SubUnit7',
                                'SunUnit8',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: w * 0.7,
                          child: TextFormField(
                            // key: widget.key,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            controller: _otpController,
                            // validator: widget.validator,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              labelText: 'Passcode',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: w / 3,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                side: BorderSide(color: Colors.white),
                              ),
                              //color: Color(0xff57c89f),
                              color: Colors.black87,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              child: Text('Login'),
                              onPressed: () {
                                switch (dropdownValue) {
                                  case "SubUnit1":
                                    _phone = '1515151515';
                                    setState(() {
                                      selectedUnit = 's1';
                                    });
                                    _saveCurrentSubUnit(1);
                                    break;

                                  case "SubUnit2":
                                    _phone = '1616161616';
                                    setState(() {
                                      selectedUnit = 's2';
                                    });
                                    _saveCurrentSubUnit(2);
                                    break;

                                  case "SubUnit3":
                                    _phone = '1717171717';
                                    setState(() {
                                      selectedUnit = 's3';
                                    });
                                    _saveCurrentSubUnit(3);
                                    break;

                                  case "SubUnit4":
                                    {
                                      _phone = '1818181818';
                                      setState(() {
                                        selectedUnit = 's4';
                                      });
                                      _saveCurrentSubUnit(4);
                                    }
                                    break;

                                  case 'SubUnit5':
                                    _phone = '1919191919';
                                    setState(() {
                                      selectedUnit = 's5';
                                    });
                                    _saveCurrentSubUnit(5);
                                    break;

                                  case 'SubUnit6':
                                    _phone = '1414141414';
                                    setState(() {
                                      selectedUnit = 's6';
                                    });
                                    _saveCurrentSubUnit(6);
                                    break;

                                  case 'SubUnit7':
                                    _phone = '1313131313';
                                    setState(() {
                                      selectedUnit = 's7';
                                    });
                                    _saveCurrentSubUnit(7);
                                    break;

                                  case 'SubUnit8':
                                    _phone = '1212121212';
                                    setState(() {
                                      selectedUnit = 's8';
                                    });
                                    _saveCurrentSubUnit(8);
                                    break;
                                  default:
                                    {
                                      print("Invalid choice");
                                    }
                                    break;
                                }

                                print(_phone);
                                registerUser(_phone, context);
                                if (_firebaseUser != null) {
                                  _otpController = TextEditingController();
                                }
                              }),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
