import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pry20220116/services/datos-medico.dart';
import 'package:pry20220116/services/datos-paciente.dart';

class ChatView extends StatefulWidget {
  final String currentUserId;
  final String anotherUserName;
  final String anotherUserId;

  final String appointmentId;

  const ChatView(
      {super.key,
      required this.currentUserId,
      required this.anotherUserName,
      required this.anotherUserId,
      required this.appointmentId});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('cita');

  //!
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  final _textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void sendMessage(String msg) {
    if (msg == '') return;
    appointments.doc(widget.appointmentId).collection('messages').add({
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'idFrom': widget.currentUserId,
      'idTo': widget.anotherUserId,
      'content': msg
    }).then((value) async {
      _textController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anotherUserName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //!Lista de mensajes
          StreamBuilder<QuerySnapshot>(
            stream: appointments
                .doc(widget.appointmentId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          Container(
            child: Row(
              children: <Widget>[
                // Edit text
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: TextField(
                      onSubmitted: (value) {
                        sendMessage(_textController.text);
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      controller: _textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Escribe un mensaje...',
                      ),
                      focusNode: focusNode,
                      autofocus: true,
                    ),
                  ),
                ),

                // Button send message
                Material(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => sendMessage(_textController.text),
                    ),
                  ),
                ),
              ],
            ),
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
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
      isMe: messageChat.idFrom == widget.currentUserId,
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
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Card(
          color: isMe ? Colors.red : Colors.blue,
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
                  style: const TextStyle(color: Colors.white, fontSize: 10.0),
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
                    fontSize: 8.0,
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
