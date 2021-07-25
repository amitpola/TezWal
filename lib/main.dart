import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tezwal/chat-bot.dart';
import 'package:tezwal/screens/recievepage.dart';
import 'package:tezwal/screens/startpage.dart';
import 'package:tezwal/screens/dashboard.dart';
import 'package:tezwal/modal/wallet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory=await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WalletAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static bool isAvailable;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  getPreferences() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      MyApp.isAvailable=preferences.getBool('isAvailable');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TezWal',
      theme: ThemeData.dark(),
      home:
      FutureBuilder(
        future: Hive.openBox<Wallet>('wallet'),
        builder: (contex,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            print('Is Available');
            if(MyApp.isAvailable!=null && MyApp.isAvailable){
              return Dashboard();
            }
            else return StartPage();
          }
          return Container();
        },
      ),
    );
  }
}

