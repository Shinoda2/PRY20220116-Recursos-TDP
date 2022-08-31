import 'package:flutter/material.dart';
import 'package:pry20220116/models/message.dart';
import 'package:pry20220116/models/patients.dart';

class IndividualPatientChat extends StatefulWidget{
  const IndividualPatientChat({Key? key , required this.patient}) : super(key: key);
  final Patient patient;
  _IndividualPatientChat createState() => _IndividualPatientChat();
}

class _IndividualPatientChat extends State<IndividualPatientChat>{
  //List<Patient> patients ;
  @override
  Widget build(BuildContext context) {
    //var patients=patient;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back,
                size: 24,),
              CircleAvatar(
                child:  Image.asset(
                    'assets/image/icon.png'
                ),
                radius: 20,
                backgroundColor: Colors.blueGrey,
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Text(widget.patient.name,
              style: const TextStyle(
                fontSize:19,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
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
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Type a message',
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon: Icon(Icons.attach_file),
                                  onPressed: (){},),
                              IconButton(icon: Icon(Icons.camera_alt),
                                onPressed: (){},)
                            ],
                          ),
                          contentPadding: EdgeInsets.all(5),
                        ),
                        onFieldSubmitted: (text){
                          final message= Message(
                              text,
                              '28/08',
                              true);
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