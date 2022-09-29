import 'package:cloud_firestore/cloud_firestore.dart';

class Medico{
  final String? nombre;
  final int? edad;
  final String? direccion;
  final int? dni;
  final String? docid;

  const Medico(
      {this.nombre,
        this.edad,
        this.direccion,
        this.dni,
        this.docid,
      });

  factory Medico.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Medico(
      nombre: data?['nombre'],
      edad: data?['edad'],
      direccion: data?['direccion'],
      dni: data?['dni_medico'],
      docid: data?['uid'],
    );
  }
}