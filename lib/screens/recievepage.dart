import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceivePage extends StatelessWidget {
  final String str;
  const ReceivePage({@required this.str});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Receive XTZ',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          QrImage(
            backgroundColor: Color(0xff3385ff),
            data: str,
            version: QrVersions.auto,
            size: 300.0,
          ),
          SizedBox(height: 24.0),
          Text(
            str,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'BreeSerif-Regular',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 60.0),
        ],
      ),
    );
  }
}