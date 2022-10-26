import 'package:cloud_firestore/cloud_firestore.dart';

class Medico {
  final String? direccion;
  final int? dni;
  final int? edad;
  final String? email;
  final String? especialidad;
  final String? nombre;
  final int? numeroCelular;
  final int? aniosTrabajados;
  final String? uid;
  final String? urlImage;

  const Medico(
      {this.direccion,
      this.dni,
      this.edad,
      this.email,
      this.especialidad,
      this.uid,
      this.urlImage,
      this.nombre,
      this.numeroCelular,
      this.aniosTrabajados});

  factory Medico.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Medico(
        direccion: data?['direccion'],
        dni: data?['dni_medico'],
        edad: data?['edad'],
        email: data?['email'],
        especialidad: data?['especialidad'],
        nombre: data?['nombre'],
        numeroCelular: data?['numero'],
        aniosTrabajados: data?['tiempo_trabajado'],
        uid: data?['uid'],
        urlImage: data?['urlImage']);
  }
}
