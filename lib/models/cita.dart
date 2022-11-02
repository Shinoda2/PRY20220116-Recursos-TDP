// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Cita {
  final String? sintoma;
  final String? citaId;
  final String? codigo_medico;
  final String? codigo_paciente;
  final Timestamp? fecha;
  final String? nombre_medico;
  final String? nombre_paciente;
  final bool? isFinished;

  Cita(
      {required this.sintoma,
      required this.citaId,
      required this.codigo_medico,
      required this.codigo_paciente,
      required this.fecha,
      required this.nombre_medico,
      required this.nombre_paciente,
      required this.isFinished});

  factory Cita.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cita(
        sintoma: data?['sintoma'],
        citaId: data?['citaId'],
        codigo_medico: data?['codigo_medico'],
        codigo_paciente: data?['codigo_paciente'],
        fecha: data?['fecha'],
        nombre_medico: data?['nombre_medico'],
        nombre_paciente: data?['nombre_paciente'],
        isFinished: data?['isFinished']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sintoma != null) "sintoma": sintoma,
      if (citaId != null) "citaId": citaId,
      if (codigo_medico != null) "codigo_medico": codigo_medico,
      if (codigo_paciente != null) "codigo_paciente": codigo_paciente,
      if (fecha != null) "fecha": fecha,
      if (nombre_medico != null) "nombre_medico": nombre_medico,
      if (nombre_paciente != null) "nombre_paciente": nombre_paciente,
      if (isFinished != null) "isFinished": isFinished,
    };
  }
}
