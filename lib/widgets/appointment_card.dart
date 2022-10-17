import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/models/especialidad.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/individual_appointment.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/individual_patient_chat.dart';
import 'package:intl/intl.dart';

import '../models/cita.dart';

enum Meses {
  _, // 0
  enero,
  febrero,
  marzo,
  abril,
  mayo,
  junio,
  julio,
  agosto,
  septiembre,
  octubre,
  noviembre,
  diciembre
}

Map<String, String> nombreDia = {
  'Monday': 'lunes',
  'Tuesday': 'martes',
  'Wednesday': 'miércoles',
  'Thursday': 'jueves',
  'Friday': 'viernes',
  'Saturday': 'sábado',
  'Sunday': 'domingo',
};

class AppointmentCard extends StatefulWidget {
  final Cita cita;
  final bool hoy;

  AppointmentCard(this.cita, {this.hoy = false});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late Future<Medical> medical;

  Future<Medical> getMedical() async {
    Medical? medico;
    await FirebaseFirestore.instance
        .collection('medico')
        .doc(widget.cita.codigo_medico!.toString())
        .get()
        .then((DocumentSnapshot res) {
      medico = Medical.fromFirestore(
          res as DocumentSnapshot<Map<String, dynamic>>, null);
      getEspecialidad(medico!.especialidadCodigo!.toString()).then((value) {
        setState(() {
          medico!.especialidad = value;
        });
      });
      print('Document data medico: ${res.data()}');
    });
    return medico!;
  }

  Future<Especialidad> getEspecialidad(String id) async {
    Especialidad? especialidad;
    await FirebaseFirestore.instance
        .collection('especialidad')
        .doc(id)
        .get()
        .then((DocumentSnapshot res) {
      especialidad = Especialidad.fromFirestore(
          res as DocumentSnapshot<Map<String, dynamic>>, null);
      print('Document data especialidad: ${res.data()}');
    });
    return especialidad!;
  }

  @override
  void initState() {
    super.initState();
    medical = getMedical();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Medical>(
        future: medical,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.especialidad != null) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndividualAppointment(
                          medical: snapshot.data!,
                          cita: widget.cita,
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: ShapeBorder.lerp(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    1,
                  ),
                  elevation: 4,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 5, right: 20),
                              child: Text(
                                  widget.hoy
                                      ? 'Hoy a las ' +
                                      DateFormat.jm().format(
                                          widget.cita.fecha!.toDate())
                                      : nombreDia[DateFormat('EEEE').format(
                                      widget.cita.fecha!.toDate())]! +
                                      ", " +
                                      widget.cita.fecha!
                                          .toDate()
                                          .day
                                          .toString() +
                                      " de " +
                                      Meses
                                          .values[widget.cita.fecha!
                                          .toDate()
                                          .month]
                                          .name +
                                      " del " +
                                      widget.cita.fecha!
                                          .toDate()
                                          .year
                                          .toString() +
                                      " " +
                                      DateFormat.jm().format(
                                          widget.cita.fecha!.toDate()),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)))),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Image.network(snapshot.data!.imagen!),
                        ),
                        title: Text(
                          snapshot.data!.nombre!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              snapshot.data!.especialidad!.nombre!,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        //trailing: Text('${patient.time}'),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 5, bottom: 10, right: 20),
                              child: Text(
                                "DIAGNÓSTICO: " +
                                    widget.cita.diagnostico!.toUpperCase(),
                                style: TextStyle(color: Colors.grey),
                              ))),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}