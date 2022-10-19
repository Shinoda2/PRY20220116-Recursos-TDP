import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utilities/constraints.dart';
import '../camera_screen.dart';

class PChatBot extends StatefulWidget {
  const PChatBot({Key? key}) : super(key: key);

  @override
  State<PChatBot> createState() => _PChatBot();
}

class _PChatBot extends State<PChatBot> {
  final inputTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

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
  final List<String> _data = [];
  static const String botURL =
      "https://chatbot-wisha-tp.azurewebsites.net/api/tp2-chatbot-wisha";

  @override
  void initState() {
    insertSingleItem(
        'Bienvenid@. Soy el Chatbot de Wisha, pregúntame algo...' '<bot>');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return burbujaMensaje(_data[index], animation, index);
              },
              reverse: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(color: Colors.black, fontSize: 12.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Escribe tu mensaje...',
                      hintStyle: kSubTitulo1,
                      fillColor: Colors.white12,
                    ),
                    focusNode: focusNode,
                    autofocus: true,
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (msg) {
                      getResponse();
                    },
                  ),
                ),
                Material(
                  child: IconButton(
                    padding: EdgeInsets.only(left: 5.0),
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      //navigateResult(context);
                    },
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getResponse() {
    if (queryController.text.isNotEmpty) {
      insertSingleItem(queryController.text);
      var client = getClient();
      Map data = {'query': queryController.text};
      var body = json.encode(data);
      try {
        // ignore: avoid_single_cascade_in_expression_statements
        client.post(
          Uri.parse(botURL),
          body: body,
        )..then((response) {
            //print(response.body);
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

Widget burbujaMensaje(String item, Animation<double> animation, int index) {
  bool isMe = !item.endsWith("<bot>");
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: isMe ? colorSecundario : colorTres,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Text(
            item.replaceAll("<bot>", ""),
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    ),
  );
}
