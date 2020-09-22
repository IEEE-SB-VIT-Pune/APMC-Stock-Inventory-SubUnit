
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subunit/authorize.dart';
import 'package:subunit/stocks_card.dart';
import 'package:subunit/transactionDetails.dart';
import 'package:subunit/transaction_entry.dart';
import 'package:subunit/Models/transactions.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {

  final id;
  final loc;

  const HomePage( {@required this.id,this.loc});

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
    print(currentUser.phoneNumber);
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
    double h = MediaQuery.of(context).size.height;
    //String idName=Firestore.instance;


      return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context)
           {
             return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff57c89f),

              bottom: TabBar(
                indicatorColor: Colors.grey,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white70,
                tabs: [
                  Tab(child:Text("Transactions",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                  Tab(child: Text("Stocks",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                  
                ],
              ),

              actions: <Widget>[

            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    _logout();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                ),
            ),
          ],

              title: Text(widget.loc,style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black),),
              

            ),



            body: TabBarView(
              children: [


                Scaffold(
                                  body: Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(widget.id + '_Transactions').orderBy("time",descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      default:
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            //print(document.data);
                            String date_ = document['time'].toDate().toString();
                            String month = '';
                            switch (date_.substring(5, 7)) {
                              case '01':
                                month = 'January';
                                break;
                              case '02':
                                month = 'February';
                                break;
                              case '03':
                                month = 'March';
                                break;
                              case '04':
                                month = 'April';
                                break;
                              case '05':
                                month = 'May';
                                break;
                              case '06':
                                month = 'June';
                                break;
                              case '07':
                                month = 'July';
                                break;
                              case '08':
                                month = 'August';
                                break;
                              case '09':
                                month = 'September';
                                break;
                              case '10':
                                month = 'October';
                                break;
                              case '11':
                                month = 'November';
                                break;
                              case '12':
                                month = 'December';
                                break;
                            }
                            return Container(
                              height: h / 8,
                              margin: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Material(
                                  color: Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.circular(15.0),
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(
                                      'Name: ${document['Name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            date_.substring(8, 9) == '0'
                                                ? Text(
                                                    '${date_.substring(9, 10)} ')
                                                : Text(
                                                    '${date_.substring(8, 10)} '),
                                            Text('$month, '),
                                            Text(date_.substring(0, 4)),
                                          ],
                                        ),
                                        Text(new DateFormat.jm()
                                            .format(DateTime.parse(date_))),
                                      ],
                                    ),
                                    onTap: () async {
                                      //print(document.data);
                                      DocumentSnapshot shopinfo =
                                          await Firestore.instance
                                              .collection('subunits')
                                              .document(widget.id)
                                              .get();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              TransactionDetails(
                                            Transactions(
                                              document['Name'] ??
                                                  shopinfo['managerName'],
                                              document['Payment Option'] ??
                                                  'Payment Mode',
                                              document['Phone Number'] ??
                                                  shopinfo['managerNo'],
                                              document['time'] ?? 'Time',
                                              document['items'] ?? 'items',
                                              document['occupation']??'occupation',
                                            ),
                                          ),
                                        ),
                                      );
                                    },

                                    onLongPress: () {
                                   // print('Delete');
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content:
                                            Text('Delete the transactions'),
                                        actions: [
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context, rootNavigator: true).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Delete'),
                                            onPressed: () async {
                                              //print('Deleting');
                                              Navigator.of(context, rootNavigator: true).pop();

                                              document.data['items'].forEach((k,v) async {
                                                //double qty0 = double.parse(v);
                                                double qty0 = double.parse(v);
                                                print(qty0);
                                                await Firestore.instance
                                              .collection('${widget.id}_stocks')
                                              .document(k)
                                              .get()
                                              .then((value) => Firestore.instance
                                               .collection('${widget.id}_stocks')
                                               .document(k)
                                               .updateData({
                                                "itemCount": (value.data['itemCount'] + qty0)
                                                }).then((_) {
                                                print("success !");
                                                 }).catchError((e) => print(e)))
                                              .catchError((e) => print(e));

                                                });

                                           await Firestore.instance.collection('${widget.id}_Transactions').document(document.documentID).delete()
                                           .then((_) {
                                           print("Transaction deleted !");
                                           
                                           });

                                              

                                              

                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },


                                  ),
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
              floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Add new transaction');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TransactionEntry(id:widget.id),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xff57c89f),
        )



                ),



                Column(
                            children: <Widget>[
                           Flexible(
              
              child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection(widget.id+"_stocks").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                          
                         
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return new ListView(
                            //shrinkWrap: true,
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new stockCard(
                                
                                itemName: document['itemName'],
                                itemQuantity: document['itemCount'].toString(),
                              );
                            }).toList(),
                          );
                              }
                            },
                          ),
                      ),
                    ]
                  ),
              ],
            ),


           
          );
         }    
        ),
      ),
    );



  }
}
