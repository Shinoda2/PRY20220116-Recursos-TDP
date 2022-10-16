import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/especialidad.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

class MedicalCard extends StatelessWidget {
  final Medical medical;
  final Especialidad especialidad;
  final String chatRoomId;
  //late Future<Especialidad> especialidad;
  final db = FirebaseFirestore.instance;
  MedicalCard(
      {required this.medical,
      required this.especialidad,
      required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualMedicalChat(
                      medical: medical,
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.network(
                  '${medical.imagen}',
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            title: Text(
              '${medical.nombre}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  '${especialidad.nombre}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            //trailing: Text('${patient.time}'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
