import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:subunit/authorize.dart';

class TransactionEntry extends StatefulWidget {

  final String id;

  const TransactionEntry({Key key, this.id}) : super(key: key);

  @override
  _TransactionEntryState createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _occupationController = new TextEditingController();
  TextEditingController _paymentModeController = new TextEditingController();
 
  List<TextEditingController> _productController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Map<String, String> selectedItems = {};
  //List <List<String>> selectedItems=[]; 
  int  itemsCount = 0;
  //String _value='Onion (कांदा)';
  

  List <String> ll=["Onion (कांदा)","Potato (बटाटा)","Garlic (लसूण)","Ginger (आले)"];
  

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();

      setState(() {});
    } catch (e) {
      setState(() {});
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print(h);
    print(w);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Entry',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xff57c89f),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: w*0.2017,
                    child: Text(
                      'Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w*0.0388,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: h*0.0512,
                    width: w*0.6562,
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFC4C4C4)),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),


              




            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:  w*0.2017,
                    child: Text(
                      'Address: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w*0.0388,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 105,
                    width: 270,
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFC4C4C4)),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your address',
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width:  w*0.2017,
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w*0.0388,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: h*0.0512,
                    width: w*0.6562,
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFC4C4C4)),
                    child: TextFormField(
                      controller: _paymentModeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter payment method',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),



            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width:  w*0.2017,
                    child: Text(
                      'Occupation ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w*0.0388,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: h*0.0512,
                    width: w*0.6562,
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFC4C4C4)),
                    child: TextFormField(
                      controller: _occupationController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your occupation',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),








            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width:  w*0.2017,
                    child: Text(
                      'Phone No.: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w*0.0388,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: h*0.0512,
                    width: w*0.6562,
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFC4C4C4)),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your phone number',
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Item',
                        style: TextStyle(
                            fontSize: w*0.0437, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: w*0.0437, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(
                        width: 150,
                        height: h*0.0512,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFC4C4C4),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton(
                          value: ll[0],
                          items: [
                            DropdownMenuItem(
                              child: Text('Onion (कांदा)'),
                              value: 'Onion (कांदा)',
                            ),
                            DropdownMenuItem(
                              child: Text('Potato (बटाटा)'),
                              value: 'Potato (बटाटा)',
                            ),
                            DropdownMenuItem(
                              child: Text('Garlic (लसूण)'),
                              value: 'Garlic (लसूण)',
                            ),
                            DropdownMenuItem(
                              child: Text('Ginger (आले)'),
                              value: 'Ginger (आले)',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              ll[0] = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(
                        width: w*0.3645,
                        height: h*0.0512,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFC4C4C4),
                        ),
                        child: TextFormField(
                          controller: _productController[0],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'quantity',
                              suffixText: ('kg'),
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: w*0.0388,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: (itemsCount >= 1)
                            ? Icon(Icons.remove_circle_outline)
                            : Icon(Icons.add_circle_outline),
                        iconSize: 28,
                        onPressed: () {
                          if (itemsCount >= 1) {
                            print('Removing....');
                            setState(() {
                              itemsCount = --itemsCount;
                            });
                          } else {
                            print('Adding....');
                            setState(() {
                              itemsCount = ++itemsCount;
                            });
                              // if (!selectedItems.containsKey(ll[0])) {
                                selectedItems[ll[0]] = _productController[0].text.toString();
                               //selectedItems.add([ll[0],_productController[0].text]);
                             // }
                          }
                          print(itemsCount);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  )
                ],
              ),
            ),
            (itemsCount >= 1)
                ? Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: ll[1],
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 'Onion (कांदा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 'Potato (बटाटा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 'Garlic (लसूण)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 'Ginger (आले)',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    ll[1] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController[1],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: w*0.0388,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: (itemsCount > 1)
                                  ? Icon(Icons.remove_circle_outline)
                                  : Icon(Icons.add_circle_outline),
                              iconSize: 28,
                              onPressed: () {
                                if (itemsCount > 1) {
                                  print('Removing....');
                                  setState(() {
                                    itemsCount = --itemsCount;
                                  });
                                } else {
                                  print('Adding....');
                                  setState(() {
                                    itemsCount = ++itemsCount;
                                  });
                                  //if (!selectedItems.containsKey(ll[1])) {
                                selectedItems[ll[1]] = _productController[1].text.toString();
                                //selectedItems.add([ll[1],_productController[1].text]);
                              //}
                                }
                                print(itemsCount);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                  )
                : Container(),
            (itemsCount >= 2)
                ? Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: ll[2],
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 'Onion (कांदा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 'Potato (बटाटा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 'Garlic (लसूण)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 'Ginger (आले)',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    ll[2] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController[2],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: w*0.0388,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: (itemsCount > 2)
                                  ? Icon(Icons.remove_circle_outline)
                                  : Icon(Icons.add_circle_outline),
                              iconSize: 28,
                              onPressed: () {
                                if (itemsCount > 2) {
                                  print('Removing....');
                                  setState(() {
                                    itemsCount = --itemsCount;
                                  });
                                } else {
                                  print('Adding....');
                                  setState(() {
                                    itemsCount = ++itemsCount;
                                  });
                                  //if (!selectedItems.containsKey(ll[2])) {
                                selectedItems[ll[2]] = _productController[2].text.toString();
                                //selectedItems.add([ll[2],_productController[2].text]);
                              //}
                                }
                                print(itemsCount);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                  )
                : Container(),
            (itemsCount >= 3)
                ? Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: ll[3],
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 'Onion (कांदा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 'Potato (बटाटा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 'Garlic (लसूण)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 'Ginger (आले)',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    ll[3] = value;
                                  });
                                 // if (!selectedItems.containsKey(ll[3])) {
                                selectedItems[ll[3]] = _productController[3].text.toString();
                                //selectedItems.add([ll[3],_productController[3].text]);
                             // }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              width: w*0.3645,
                        height: h*0.0512,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController[3],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: w*0.0388,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.0,
                        )
                      ],
                    ),
                  )
                : Container(),
            Center(
              child: RaisedButton(
                onPressed: () async {//'time': Timestamp.fromDate(DateTime.now()),

                Navigator.pop(context);

                
                  
                                      for(int i = 0; i < 4; i++) {
                      if(_productController[i].text != '') {
                        selectedItems[ll[i]] = _productController[i].text;
                      }
                    }
                     print(_nameController.text);
                    print(_paymentModeController.text);
                    print(_phoneNumberController.text);
                     print(selectedItems);
                     print(_occupationController.text);
                     print(Timestamp.fromDate(DateTime.now()));
                     Timestamp d=Timestamp.fromDate(DateTime.now());

                      
                      
                      // for(int i = 0; i < 4; i++) {
                      //   if (ll[i] != null && _productController[i] != null) {
                      //                   double qty0 = double.parse(_productController[i].text);
                      //                   await Firestore.instance
                      //                       .collection('${widget.id}_stocks')
                      //           .document(ll[i])
                      //           .get()
                      //           .then((value)  {

                      //             if(value.data['itemCount'] - qty0 >= 0.0)
                      //             {
                      //               Firestore.instance
                      //           .collection('${widget.id}_stocks')
                      //           .document(ll[i])
                      //           .updateData({
                      //         "itemCount": (value.data['itemCount'] - qty0)
                      //       }).then((_) {
                              
                      //       }).catchError((e) => print(e));
                      //    }})
                         
                      //   .catchError((e) => print(e));
                      //   }
                      //   else
                      //   {
                      //     Fluttertoast.showToast(
                      //                     msg: "This is Toast messaget",
                      //                     toastLength: Toast.LENGTH_SHORT,
                      //                     gravity: ToastGravity.CENTER,
                      //                     //timeInSecForIos: 1
                      //                 );
                      //   }
                      // }






                        
                        for(int i = 0; i < 4; i++) {
                        if (ll[i] != null && _productController[i] != null) {
                                        double qty0 = double.parse(_productController[i].text);
                                        await Firestore.instance
                                            .collection('${widget.id}_stocks')
                                .document(ll[i])
                                .get()
                                .then((value)  {

                                  if(value.data['itemCount'] - qty0 >= 0.0)
                                  {
                                    Firestore.instance
                                .collection('${widget.id}_stocks')
                                .document(ll[i])
                                .updateData({
                              "itemCount": (value.data['itemCount'] - qty0)
                            }).then((_) {

                              Firestore.instance.collection(widget.id + '_Transactions').document(d.toString()).setData({
                                        'Name' : _nameController.text,
                                        'Payment Option' :_paymentModeController.text,
                                        'Phone Number' : _phoneNumberController.text,
                                        'occupation':_occupationController.text,
                                        'address':_addressController.text,
                                        'items': selectedItems,
                                        'time':  Timestamp.fromDate(DateTime.now()),


                                      }).then((value){

                                        
                                    });
                              print("success $i!");
                              
                            }).catchError((e) => print(e));
                         }})
                         
                        .catchError((e) => print(e));
                        }
                        else
                        {
                          Fluttertoast.showToast(
                                          msg: "This is Toast messaget",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          //timeInSecForIos: 1
                                      );
                        }
                      }
                      
                    },
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              side: BorderSide(color: Colors.grey)),
                                color: Color(0xff57c89f),
                            child: Text(
                              'ADD',
                              style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
