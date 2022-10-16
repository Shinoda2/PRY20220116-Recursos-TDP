//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

import '../models/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final String chatRoomId;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  PatientCard(
      this.patient, this.chatRoomId, this.lastMessage, this.lastMessageTime);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPatientChat(
                      patient: patient,
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset('assets/image/icon.png'),
            ),
            title: Text(
              '${patient.nombre}',
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
                  lastMessage!,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            trailing: Text(DateFormat.jm().format(lastMessageTime!)),
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
