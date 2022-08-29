import 'package:flutter/material.dart';
import 'package:pry20220116/models/patients.dart';

class IndividualPatientChat extends StatefulWidget{
  /*final Patient patient;
  IndividualPatientChat(Key key,this.patient) : super(key: key);*/
  //@override
  _IndividualPatientChat createState() => _IndividualPatientChat();
}

class _IndividualPatientChat extends State<IndividualPatientChat>{
  List<Patient> patients = Patient.generatePatient();
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
              Icon(Icons.arrow_back,
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
            Text('Name',
              style: TextStyle(
                fontSize:19,
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