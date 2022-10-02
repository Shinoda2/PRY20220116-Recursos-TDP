import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/especialidad.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

class MedicalCard extends StatelessWidget {
  final Medical medical;
  //late Future<Especialidad> especialidad;
  final db = FirebaseFirestore.instance;
  MedicalCard(this.medical);

  // Future<Especialidad> getEspecialidad() async {
  //   Especialidad especialidad = Especialidad();
  //   final docRef = db.collection("especialidad").doc("1");
  //   await docRef.get().then(
  //     (DocumentSnapshot doc) {
  //       final data = doc.data() as DocumentSnapshot<Map<String, dynamic>>;
  //       especialidad = Especialidad.fromFirestore(data, null);
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  //   return especialidad;
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Especialidad>(
    //     future: especialidad,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualMedicalChat(medical: medical)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Image.network('${medical.imagen}')),
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
                  '${medical.especialidadCodigo}',
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
    // } else if (snapshot.hasError) {
    //   return const Text("Error");
    // }
    // return const Center(child: CircularProgressIndicator());
    // });
  }
}
