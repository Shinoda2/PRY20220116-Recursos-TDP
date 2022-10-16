import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/models/message.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/camera_screen.dart';

import '../utils/constants.dart';

class IndividualMedicalChat extends StatefulWidget {
  const IndividualMedicalChat(
      {Key? key, required this.medical, required this.chatRoomId})
      : super(key: key);
  final Medical medical;
  final String chatRoomId;
  _IndividualMedicalChat createState() => _IndividualMedicalChat();
}

class _IndividualMedicalChat extends State<IndividualMedicalChat> {
  //List<Patient> patients ;
  final inputTextController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>>? chatMessagesStream;

  Widget chatMessageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data();
                  return MessageTile(
                    message: snapshot.data!.docs[index].data()["message"],
                    sendByMe: Constants.name ==
                        snapshot.data!.docs[index].data()["sentBy"],
                  );
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (inputTextController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": inputTextController.text,
        "sentBy": "paciente",
        'time': Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
      };

      addConversationMessages(widget.chatRoomId, messageMap);

      setState(() {
        inputTextController.text = "";
      });
    }
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
  }

  Future<void> navigateResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    ).then((value) {
      setState(() {
        inputTextController.text += value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //var patients=patient;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                child: Image.asset('assets/image/icon.png'),
                radius: 20,
                backgroundColor: Colors.blueGrey,
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Text(
              widget.medical.nombre!,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            chatMessageList(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: inputTextController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        onEditingComplete: (() {
                          sendMessage();
                        }),
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Type a message',
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  navigateResult(context);
                                },
                              )
                            ],
                          ),
                          contentPadding: EdgeInsets.all(5),
                        ),
                        onFieldSubmitted: (text) {
                          final message = Message(text, '28/08', true);
                        },
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CircleAvatar(
                      radius: 25,
                      child: IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: (){},
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
