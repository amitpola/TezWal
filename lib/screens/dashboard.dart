import 'dart:io';
import 'package:tezwal/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tezster_dart/tezster_dart.dart';
import 'package:tezwal/modal/wallet.dart';
import 'package:tezwal/screens/recievepage.dart';
import 'package:tezwal/screens/startpage.dart';

import '../chat-bot.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  Wallet _wallet;
  String _amountString;
  final String server = 'https://rpcalpha.tzbeta.net';
  final double currentValue = 2.82;

  getBalance(String walletAddress) async {
    String balance = await TezsterDart.getBalance(
      walletAddress,
      server, // testnet address
    );

    setState(() {
      _amountString = (double.parse(balance) / 1000000).toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();

    final walletBox = Hive.box<Wallet>('wallet');
    _wallet = walletBox.get(0);

    _amountString = (double.parse(_wallet.amount) / 1000000).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'DashBoard',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Fuggles-Regular',
                letterSpacing: 2,
                fontSize: 40,
                color: Color(0xff00ff00)
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Other Options',
                  style: TextStyle(
                    color: Color(0xff00ff00),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 2,
                    fontFamily: 'Fuggles-Regular'
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                  'Home',
                style: TextStyle(
                  fontFamily: 'Fuggles-Regular',
                  fontSize: 30,
                  fontWeight: FontWeight.w900
                ),
              ),
              onTap: (){
                Navigator.of(context).push( MaterialPageRoute(builder: (context)=>StartPage(),));
              },
              trailing: IconButton(
                icon: Icon(Icons.home,color: Color(0xff00ff00),),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text(
                'Create - Wallet',
                style: TextStyle(
                    fontFamily: 'Fuggles-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w900
                ),
              ),
              onTap: (){
                Navigator.of(context).push( MaterialPageRoute(builder: (context)=>StartPage(),));
              },
              trailing: IconButton(
                icon: Icon(Icons.folder_shared_rounded,color: Color(0xff00ff00),),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                    fontFamily: 'Fuggles-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w900
                ),
              ),
              onTap: (){
                Navigator.of(context).push( MaterialPageRoute(builder: (context)=>ChatBot(),));
              },
              trailing: IconButton(
                icon: Icon(Icons.help,color: Color(0xff00ff00),),
              ),
            ),
            ListTile(
              title: Text(
                'Exit',
                style: TextStyle(
                    fontFamily: 'Fuggles-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w900
                ),
              ),
              onTap: (){
                setState(() {
                  MyApp.isAvailable=!MyApp.isAvailable;
                });
                exit(0);
              },
              trailing: IconButton(
                icon: Icon(Icons.close,color: Color(0xff00ff00),),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          children: [
            Row(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif-Regular',
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _amountString,
                      style: TextStyle(
                        color: Color(0xff00ff00),
                        fontFamily: 'BreeSerif-Regular',
                        fontWeight: FontWeight.w400,
                        fontSize: 50.0,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 8.0),

                  ],
                ),
                SizedBox(height: 24.0),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontFamily: 'BreeSerif-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReceivePage(str: _wallet.pkh),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Receive',
                      style: TextStyle(
                        fontFamily: 'BreeSerif-Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.0),
            Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _amountString + ' XTZ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'BreeSerif-Regular',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              (double.parse(_amountString) * currentValue)
                                  .toStringAsFixed(2) +
                                  ' USD',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'BreeSerif-Regular',
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$ $currentValue',
                            style: TextStyle(
                              color: Color(0xff00ff00),
                              fontFamily: 'BreeSerif-Regular',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
