import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_http_post_request/model/login_model.dart';
import 'package:flutter_http_post_request/pages/login_page.dart';


class MyApps extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class AIRequestModel {
  List messsages;

  AIRequestModel({
    this.messsages,

  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'messages': messsages.toString(),
    };
    return map;
  }
}
class _MyAppState extends State<MyApps> {
  void response(query) async {
  Future<AIResponseModel> login(AIResponseModel requestModel) async{

  }
}
  final messageInsert = TextEditingController();
  List<Map> messages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SSAT Bot",
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => chat(
                        messages[index]["message"].toString(),
                        messages[index]["data"]))),
            Divider(
              height: 5.0,
              color: Colors.deepOrange,
            ),
            //User Input text area
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                        controller: messageInsert,
                        decoration: InputDecoration.collapsed(
                            hintText: "Send your message",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          //check if there is empty message or response text message
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messages.insert(0,
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
          color: data == 0 ? Colors.deepOrange : Colors.orangeAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )),
    );
  }
}

//control that server response is valid form
bool responseFinal() {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final form = globalFormKey.currentState;
  if (form.validate()) {
    form.save();
    return true;
  }
  return false;
}

// if there is response from server, create answer bubble with the buttons
Widget chat(String message, int data) {
  if (responseFinal() == false  && message.isEmpty) {
    AIResponseModel messages = AIResponseModel();
    return AlertDialog(
      title: Text('Error'),
      content: Text("Server error."),
      actions: <Widget>[
        FlatButton(
          child: Text("CANCEL"),
          onPressed: () {
            print("there is no answer");
          },
        ),
      ],
    );
  }else if(responseFinal() == true){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Colors.green : Colors.orangeAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
      ),
    );
  }else{
    showAlert(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SELECT A BUTTON'),
            content: Text("Are You Sure Want To Proceed ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("true"),
                onPressed: () {
                  Navigator.of(context).pop(LoginPage());
                },
              ),

              FlatButton(
                child: Text("false"),
                onPressed: ()=> exit(0),
              ),
            ],
          );
        },
      );
    }
  }
}
