import 'package:flutter/material.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

class MedicalCard extends StatelessWidget{
  final Medical medical;
  MedicalCard(this.medical);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualMedicalChat(medical: medical)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset(
                  '${medical.icon}'
              ),
            ),
            title: Text('${medical.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
            subtitle: Row(
              children:[
                Text('${medical.especialidad}',
                  style: TextStyle(
                    fontSize: 13,
                  ),)
              ],
            ),
            //trailing: Text('${patient.time}'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
                thickness: 1
            ),
          ),
        ],
      ),
    );

  }

}