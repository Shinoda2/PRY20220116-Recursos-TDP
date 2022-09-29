import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente{
  final String? nombre;
  final int? edad;
  final String? direccion;
  final int? dni;

  const Paciente(
      {this.nombre,
        this.edad,
        this.direccion,
        this.dni,
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
    );
  }
}