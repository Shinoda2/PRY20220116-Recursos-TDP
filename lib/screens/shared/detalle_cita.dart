// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pry20220116/models/cita.dart';
import 'package:pry20220116/models/usuario.dart';
import 'package:pry20220116/services/datos_citas.dart';
import 'package:pry20220116/services/datos_usuario.dart';
import '../../utilities/constraints.dart';

class DetalleCitaPage extends StatefulWidget {
  final String citaId;

  const DetalleCitaPage({
    super.key,
    required this.citaId,
  });

  @override
  State<DetalleCitaPage> createState() => _DetalleCitaPageState();
}

class _DetalleCitaPageState extends State<DetalleCitaPage> {
  AdminService adminService = AdminService();
  AppointmentService appointmentService = AppointmentService();

  DateTime dateTime = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("cita")
                .doc(widget.citaId)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              var citaDocument = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cldetalleCita(citaDocument!),
                  btnEditarCita(),
                  btnFinalizarCita()
                ],
              );
            }),
      ),
    );
  }

  Widget cldetalleCita(DocumentSnapshot<Object?> citaDocument) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text('DETALLES DE CITA', style: kTitulo1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text('Paciente: ${citaDocument["nombre_paciente"]}'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Médico: ${citaDocument["nombre_medico"]}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Fecha : ' +
                DateFormat('dd/MM/y hh:mm a')
                    .format((citaDocument["fecha"] as Timestamp).toDate()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Síntomas: ${citaDocument["sintoma"]}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: citaDocument["isFinished"]
              ? Text(
                  'Estado: Finalizado',
                )
              : Text(
                  'Estado: Pendiente',
                ),
        ),
      ],
    );
  }

  Widget btnEditarCita() {
    return FutureBuilder<Cita>(
        future: appointmentService.getCitaByUID(widget.citaId),
        builder: (context, userSnap) {
          if (!userSnap.hasData) {
            return CircularProgressIndicator();
          }
          if (userSnap.data!.isFinished!) {
            return SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
                onPressed: () async {
                  DateTime? date = await pickDate(context, dateTime);
                  if (date == null) return;

                  TimeOfDay? time = await pickTime(context, dateTime);
                  if (time == null) return;

                  final dt = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('¿Estás seguro?'),
                          content: Text(
                              'Vas a editar el horario de la cita para las ' +
                                  DateFormat('dd/MM/y hh:mm a').format(dt)),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar.')),
                            TextButton(
                                onPressed: () {
                                  appointmentService.editarCita(
                                      widget.citaId, Timestamp.fromDate(dt));
                                  Navigator.pop(context);
                                },
                                child: Text('Si.'))
                          ],
                        );
                      });
                },
                child: Text("Editar fecha")),
          );
        });
  }

  Widget btnFinalizarCita() {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<Usuario>(
        future: adminService.getUserByUID(currentUserID),
        builder: (context, userSnap) {
          if (!userSnap.hasData) {
            return CircularProgressIndicator();
          }
          if (userSnap.data!.rol! != "medico") {
            return SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
                onPressed: () {
                  appointmentService.finalizarCita(widget.citaId);
                  debugPrint("Cambio");
                },
                child: Text("Finalizar cita")),
          );
        });
  }
}

Future<DateTime?> pickDate(BuildContext context, DateTime dateTime) =>
    showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime.now().add(Duration(days: 7)));

Future<TimeOfDay?> pickTime(BuildContext context, DateTime dateTime) =>
    showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
