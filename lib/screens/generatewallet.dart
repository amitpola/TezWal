import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezwal/modal/wallet.dart';
import 'package:tezwal/screens/walletinfo.dart';

class GenerateWalletPage extends StatefulWidget {
  @override
  _GenerateWalletPageState createState() => _GenerateWalletPageState();
}

class _GenerateWalletPageState extends State<GenerateWalletPage> {
  InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 140),
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Center(
                        child: Center(
                          child: Text(
                            "Create wallet",
                            style: TextStyle(
                              color: Color(0xff00ff00),
                              fontFamily: 'Fuggles-Regular',
                              fontWeight: FontWeight.w900,
                              fontSize: 40.0,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Complete the following steps to create your tezos wallet.",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'BreeSerif-Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialUrl: 'https://faucet.tzalpha.net/',
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    // debuggingEnabled: true,
                    useOnDownloadStart: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {},
                onLoadStop: (InAppWebViewController controller, String url) {},
                onDownloadStart: (controller, url) async {
                  var rawJson = Uri.decodeFull(url.split(',')[1]);
                  Wallet newWallet = Wallet.fromJson(jsonDecode(rawJson));

                  print(newWallet.amount);


                  Hive.box<Wallet>('wallet').add(newWallet);

                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  await prefs.setBool('isAvailable', true);

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => WalletInfoPage(
                        wallet: newWallet,
                      ),
                    ),
                    ModalRoute.withName('/'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}