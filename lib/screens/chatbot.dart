import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar.dart';

import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'dart:convert';

import '../widgets/navigation_bar.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "https://chatbot-wisha.azurewebsites.net/api/tp2-chatbot-wisha";
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    insertSingleItem('Bienvenido. Soy Dylan el Chatbot.' + '<bot>');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text('Chatbot'),
        ),
        body: Stack(
          children: <Widget>[
            AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder:
                  (BuildContext context, int index, Animation<double> animation) {
                return buildItem(_data[index], animation, index);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorFiltered(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        icon: Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        hintText: "¡Hola Bot!",
                        fillColor: Colors.white12,
                      ),
                      controller: queryController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (msg) {
                        getResponse();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBarB());
  }

  void getResponse() {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text);
      var client = getClient();
      Map data = {'query': queryController.text};
      var body = json.encode(data);
      try {
        // ignore: avoid_single_cascade_in_expression_statements
        client.post(
          Uri.parse(BOT_URL),
          body: body,
        )..then((response) {
          print(response.body);
          //Map<String, dynamic> data = jsonDecode(response.body);
          insertSingleItem(response.body + '<bot>');
        });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState?.insertItem(_data.length - 1);
  }

  http.Client getClient() {
    return http.Client();
  }
}

Widget buildItem(String item, Animation<double> animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          // ignore: sort_child_properties_last
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(color: mine ? Colors.white : Colors.black),
          ),
          color: mine ? Colors.blue : Colors.grey[200],
          padding: BubbleEdges.all(10),
        ),
      ),
    ),
  );

}
