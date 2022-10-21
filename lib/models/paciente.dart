import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente {
  final String? alergia;
  final String? codigo_medico;
  final String? direccion;
  final int? dni;
  final int? edad;
  final String? email;
  final String? nombre;
  final int? numero_telefono;
  final String? uid;
  final String? urlImage;

  const Paciente({
    this.alergia,
    this.codigo_medico,
    this.direccion,
    this.dni,
    this.edad,
    this.email,
    this.nombre,
    this.numero_telefono,
    this.uid,
    this.urlImage,
  });

  factory Paciente.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Paciente(
        alergia: data?['alergia'],
        codigo_medico: data?['codigo_medico'],
        direccion: data?['direccion'],
        dni: data?['dni_paciente'],
        edad: data?['edad'],
        email: data?['email'],
        nombre: data?['nombre'],
        numero_telefono: data?['numero_telefono'],
        uid: data?['uid'],
        urlImage: data?['urlImage']);
  }
}
