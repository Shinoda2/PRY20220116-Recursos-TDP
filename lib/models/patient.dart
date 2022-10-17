import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente {
  String? alergia;
  String? direccion;
  int? dniPaciente;
  int? edad;
  String? email;
  String? nombre;
  int? numeroTelefono;
  final String? docid;

  Paciente(
      { this.alergia,
         this.direccion,
         this.dniPaciente,
         this.edad,
         this.email,
         this.docid,
         this.nombre,
         this.numeroTelefono});

  factory Paciente.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Paciente(
      alergia: data?['alergia'],
      direccion: data?['direccion'],
      dniPaciente: data?['dni_paciente'],
      edad: data?['edad'],
      docid: data?['uid'],
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