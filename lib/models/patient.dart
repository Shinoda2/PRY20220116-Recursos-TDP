import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String? alergia;
  String? direccion;
  int? dniPaciente;
  int? edad;
  String? email;
  String? nombre;
  int? numeroTelefono;

  Patient(
      {required this.alergia,
      required this.direccion,
      required this.dniPaciente,
      required this.edad,
      required this.email,
      required this.nombre,
      required this.numeroTelefono});

  factory Patient.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Patient(
      alergia: data?['alergia'],
      direccion: data?['direccion'],
      dniPaciente: data?['dni_paciente'],
      edad: data?['edad'],
      email: data?['email'],
      nombre: data?['nombre'],
      numeroTelefono: data?['numero_telefono'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (alergia != null) "alergia": alergia,
      if (direccion != null) "direccion": direccion,
      if (dniPaciente != null) "dni_paciente": dniPaciente,
      if (edad != null) "edad": edad,
      if (email != null) "email": email,
      if (nombre != null) "nombre": nombre,
      if (numeroTelefono != null) "numero_telefono": numeroTelefono,
    };
  }
}
