import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tezwal/chat-bot.dart';
import 'package:tezwal/screens/dashboard.dart';
import 'package:tezwal/screens/generatewallet.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StartPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<StartPage> {

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatBot()));
        },
        backgroundColor: Color(0xff00ff00),
        child: Icon(Icons.perm_identity,color: Colors.black,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TyperAnimatedTextKit(
                        text: ['Tez-Wal'],
                        textStyle: TextStyle(
                          fontFamily: 'Fuggles-Regular',
                          fontWeight: FontWeight.w500,
                          fontSize: 100,
                          color: Color(0xff00ff00)
                        ),
                      ),
                      Text(
                        'inspired by Tezos',
                        style: TextStyle(
                          fontFamily: 'BreeSerif-Regular',
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.5,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(0,2)
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                  child: RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                           builder: (context) => GenerateWalletPage(),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 16.0,
                      ),
                      child: Text(
                        'Create my wallet',
                        style: TextStyle(
                          fontFamily: 'BreeSerif-Regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.download_rounded,
                      color: Color(0xff00ff00),
                      size: 32.0,
                    ),
                    SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard(),));
                      },
                      child: Expanded(
                        child: Text(
                          'Already have a wallet? Click here ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BreeSerif-Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}