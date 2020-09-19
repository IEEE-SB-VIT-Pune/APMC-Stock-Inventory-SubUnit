import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subunit/Models/transactions.dart';
import 'package:subunit/authorize.dart';
import 'package:subunit/transactionDetails.dart';
import 'package:subunit/transaction_entry.dart';

class HomePage extends StatefulWidget {
  String unit;

  HomePage([this.unit = 'Nothing']);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;

  @override
  initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            RaisedButton(
                color: Colors.red,
                child: Text('Logout'),
                onPressed: () {
                  _logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ));
                })
          ],
          bottom: PreferredSize(
            preferredSize: Size(40, 40),
            child: TabBar(
              indicatorWeight: 5,
              indicatorColor: Color(0xFFAF2323),
              tabs: [
                Container(
                  height: 30,
                  child: Text(
                    'Transactions',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: 30,
                  child: Text(
                    'Stocks',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(widget.unit + '_Transactions')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
                      default:
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            print(document.data);
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                child: ListTile(
                                  title: Text(document['Name']),
                                  trailing: Container(
                                    width: 100,
                                    child: Text(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                              document['time']
                                                  .microsecondsSinceEpoch)
                                          .toString(),
                                    ),
                                  ),
                                  onLongPress: () {
                                    print('Delete');
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content:
                                            Text('Delete the transactions'),
                                        actions: [
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              print('Deleting');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onTap: () {
                                    print(document.data);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TransactionDetails(
                                          Transactions(
                                            document['Name'] ?? 'Name',
                                            document['Payment Option'] ??
                                                'Payment Mode',
                                            document['Phone Number'] ??
                                                'Phone Number',
                                            document['time'] ?? 'Time',
                                            document['items'] ?? 'items',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ),
            Text('Stocks'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Add new transaction');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TransactionEntry(),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
