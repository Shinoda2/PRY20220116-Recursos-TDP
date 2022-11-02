// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'package:pry20220116/utilities/constraints.dart';
import 'dart:convert';

import 'camera_screen.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPage();
}

class _ChatBotPage extends State<ChatBotPage> {
  final inputTextController = TextEditingController();
  TextEditingController queryController = TextEditingController();

  Future<void> navigateResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    ).then((value) {
      setState(() {
        queryController.text += value;
      });
    });
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "https://chatbot-wisha-tp.azurewebsites.net/api/tp2-chatbot-wisha";

  @override
  void initState() {
    insertSingleItem(
        'Bienvenido. Soy el Chatbot de Wisha, pregúntame algo...' + '<bot>');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      height: 40.0,
                      child: TextField(
                        onSubmitted: (value) {
                          getResponse();
                        },
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1.0, color: colorTres),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1.0, color: colorTres),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: 'Escribe tu mensaje...',
                          hintStyle: kHintText,
                        ),
                        controller: queryController,
                      ),
                    ),
                  ),
                  // Button send message
                  Material(
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.send),
                      onPressed: () => getResponse(),
                    ),
                  ),
                  Material(
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        navigateResult(context);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
  bool isMine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: isMine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          // ignore: sort_child_properties_last
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(color: isMine ? Colors.white : Colors.black),
          ),
          color: isMine ? Colors.blue : Colors.grey[200],
          padding: BubbleEdges.all(10),
        ),
      ),
    ),
  );
}
