import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/models/lista_medicos.dart';
import 'package:pry20220116/models/lista_pacientes.dart';
import 'package:pry20220116/screens/individual_appointment.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  AppointmentCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualAppointment(
                      appointment: appointment,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset('${appointment.icon}'),
            ),
            title: Text(
              '${appointment.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  '${appointment.especialidad}',
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
