import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:bubble/bubble.dart';
import 'package:tezwal/screens/startpage.dart';

class ChatBot extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ChatBot> {
  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/kallu-oaal-773d7ea19b97.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.home_filled,color: Color(0xff00ff00),),
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>StartPage()),
                );
              }),
        ],
        elevation: 0,
        title: Center(
          child: Text(
            "Tez Bot",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Fuggles-Regular',
                letterSpacing: 2,
                fontSize: 40,
                color: Color(0xff00ff00)
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Divider(
              height: 5.0,
              color: Color(0xff00ff00),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                        controller: messageInsert,
                        decoration: InputDecoration.collapsed(
                            hintText: "Ask me......",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              fontFamily: "BreeSerif-Regular"
                            )),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(

                        icon: Icon(
                          Icons.send_rounded,
                          size: 30.0,
                          color: Color(0xff66ffff),
                        ),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messsages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            response(messageInsert.text);
                            messageInsert.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Color(0xffff9e3d) : Color(0xff66ffff),
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,fontFamily: "BreeSerif-Regular",fontSize: 15),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(
                      data == 0 ? "assets/images/bot.jpg" : "assets/images/user.jpg"),
                ),
              ],
            ),
          )),
    );
  }
}