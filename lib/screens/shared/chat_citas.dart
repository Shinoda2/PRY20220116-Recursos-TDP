// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utilities/constraints.dart';
import 'camera_screen.dart';

class ChatView extends StatefulWidget {
  final String _idUsuarioActual;
  final String _nombreReceptor;
  final String _idReceptor;
  final String _idCita;
  final bool _finalizado;

  const ChatView(
      {super.key,
      required String currentUserId,
      required String anotherUserName,
      required String anotherUserId,
      required String appointmentId,
      required bool isFinished})
      : _idCita = appointmentId,
        _idReceptor = anotherUserId,
        _finalizado = isFinished,
        _nombreReceptor = anotherUserName,
        _idUsuarioActual = currentUserId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference citas = FirebaseFirestore.instance.collection('cita');

  var currentUserEmail = FirebaseAuth.instance.currentUser;

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Future<void> navigateResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    ).then((value) {
      setState(() {
        _textController.text += value;
      });
    });
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    citas.doc(widget._idCita).collection('messages').add({
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'idFrom': widget._idUsuarioActual,
      'idTo': widget._idReceptor,
      'content': msg
    }).then((value) async {
      _textController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._nombreReceptor, style: kTituloCabezera),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          children: [
            //!Lista de mensajes
            StreamBuilder<QuerySnapshot>(
              stream: citas
                  .doc(widget._idCita)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Algo salió mal"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Todavia no se han enviado mensajes"),
                  );
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: snapshot.data!.docs
                        .map<Widget>((DocumentSnapshot document) {
                      return buildItem(document);
                    }).toList(),
                  ),
                );
              },
            ),
            //!Input Content
            buildSendButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildSendButton(BuildContext context) {
    //print(widget._finalizado);
    if (widget._finalizado) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text("El chat ha finalizado y no se pueden enviar más mensajes"),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: SizedBox(
              height: 40.0,
              child: TextField(
                onSubmitted: (value) {
                  sendMessage(_textController.text);
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
                    borderSide: const BorderSide(width: 1.0, color: colorTres),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.0, color: colorTres),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Escribe tu mensaje...',
                  hintStyle: kHintText,
                ),
                focusNode: _focusNode,
                controller: _textController,
              ),
            ),
          ),
          // Button send message
          Material(
            child: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.send),
              onPressed: () => sendMessage(_textController.text),
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
    );
  }

  Widget buildItem(DocumentSnapshot? document) {
    if (document == null) {
      return const SizedBox.shrink();
    }
    MessageChat messageChat = MessageChat.fromDocument(document);
    return BurbujaMensaje(
      messageChat: messageChat,
      isMe: messageChat.idFrom == widget._idUsuarioActual,
    );
  }
}

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;

  MessageChat(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content});

  Map<String, dynamic> toJson() {
    return {
      "idFrom": idFrom,
      "idTo": idTo,
      "timestamp": timestamp,
      "content": content,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get("idFrom");
    String idTo = doc.get("idTo");
    String timestamp = doc.get("timestamp");
    String content = doc.get("content");
    return MessageChat(
        idFrom: idFrom, idTo: idTo, timestamp: timestamp, content: content);
  }
}

class BurbujaMensaje extends StatelessWidget {
  const BurbujaMensaje({
    Key? key,
    required this.messageChat,
    required this.isMe,
  }) : super(key: key);

  final MessageChat messageChat;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
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
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  messageChat.content,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
                Text(
                  DateFormat('d/M kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      int.parse(messageChat.timestamp),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
