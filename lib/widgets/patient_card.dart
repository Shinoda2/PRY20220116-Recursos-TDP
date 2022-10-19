//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/lista_pacientes.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  PatientCard(this.patient);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPatientChat(patient: patient)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset('${patient.icon}'),
            ),
            title: Text(
              '${patient.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '${patient.currentMessage}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            trailing: Text('${patient.time}'),
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
