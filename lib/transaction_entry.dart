import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subunit/authorize.dart';

class TransactionEntry extends StatefulWidget {
  @override
  _TransactionEntryState createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  Map<String, TextEditingController> _productController = {};
  int _value = 1, itemsCount = 1;

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
    ['0', '1', '2', '3'].forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      _productController.putIfAbsent(str, () => textEditingController);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry'),
        actions: [
          RaisedButton(
            color: Colors.red,
            child: Text('Logout'),
            onPressed: () {
              _logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 35,
                    width: 200,
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
                    width: 80,
                    child: Text(
                      'Address: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 105,
                    width: 200,
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
                    width: 80,
                    child: Text(
                      'Phone No.: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: 35,
                    width: 200,
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFC4C4C4),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text('Onion (कांदा)'),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text('Potato (बटाटा)'),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text('Garlic (लसूण)'),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text('Ginger (आले)'),
                              value: 4,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
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
                        width: 150,
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFC4C4C4),
                        ),
                        child: TextFormField(
                          controller: _productController['0'],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'quantity',
                              suffixText: ('kg'),
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
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
                              width: 150,
                              height: 35,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController['1'],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
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
                              width: 150,
                              height: 35,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController['2'],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DropdownButton(
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
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
                              width: 150,
                              height: 35,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4),
                              ),
                              child: TextFormField(
                                controller: _productController['3'],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'quantity',
                                    suffixText: ('kg'),
                                    suffixStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                onPressed: () {
                  print('Adding final items');
                },
                color: Colors.red,
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
