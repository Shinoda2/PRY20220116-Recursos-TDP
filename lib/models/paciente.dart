import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente{
  final String? nombre;
  final int? edad;
  final String? direccion;
  final int? dni;
  final String? docid;
  final Timestamp? fecha_hora;

  const Paciente(
      {this.nombre,
        this.edad,
        this.direccion,
        this.dni,
        this.docid,
        this.fecha_hora,
      });

  factory Paciente.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Paciente(
      nombre: data?['nombre'],
      edad: data?['edad'],
      direccion: data?['direccion'],
      dni: data?['dni_paciente'],
      docid: data?['uid'],
      fecha_hora: data?['fecha_hora'],
    );
  }
}