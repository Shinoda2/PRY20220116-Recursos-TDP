import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente {
  final String? alergia;
  final String? direccion;
  final String? dni;
  final String? edad;
  final String? email;
  final String? nombre;
  final String? telefono;
  final String? uid;
  final String? urlImage;

  const Paciente({
    this.alergia,
    this.direccion,
    this.dni,
    this.edad,
    this.email,
    this.nombre,
    this.telefono,
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
        direccion: data?['direccion'],
        dni: data?['dni'],
        edad: data?['edad'],
        email: data?['email'],
        nombre: data?['nombre'],
        telefono: data?['telefono'],
        uid: data?['uid'],
        urlImage: data?['urlImage']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (alergia != null) "alergia": alergia,
      if (direccion != null) "direccion": direccion,
      if (dni != null) "dni": dni,
      if (edad != null) "edad": edad,
      if (email != null) "email": email,
      if (nombre != null) "nombre": nombre,
      if (telefono != null) "telefono": telefono,
      if (uid != null) "uid": uid,
      if (urlImage != null) "urlImage": urlImage
    };
  }
}
