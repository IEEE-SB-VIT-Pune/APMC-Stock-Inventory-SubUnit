import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:subunit/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  // TextEditingController emailInputController;

  // TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController pwdInputController;
  FirebaseUser _firebaseUser;
  String dropdownValue;

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
                builder: (context) => HomePage(),
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

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((e) {
      print(e);
      showDialog(
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

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 48,
              width: w - 40,
              padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[400])),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
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
              height: 40,
            ),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'passcode'),
              maxLength: 6,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  switch (dropdownValue) {
                    case "SubUnit1":
                      _phone = '1515151515';
                      break;

                    case "SubUnit2":
                      _phone = '1616161616';
                      break;

                    case "SubUnit3":
                      _phone = '1717171717';
                      break;

                    case "SubUnit4":
                      {
                        _phone = '1818181818';
                      }
                      break;

                    case 'SubUnit5':
                      _phone = '1919191919';
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
                })
          ],
        ),
      ),
    );
  }
}
