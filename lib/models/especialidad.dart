import 'package:cloud_firestore/cloud_firestore.dart';

class Especialidad {
  final String? nombre;
  final String? descripcion;

  Especialidad({
    this.nombre,
    this.descripcion,
  });

  factory Especialidad.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Especialidad(
      nombre: data?['nombre'],
      descripcion: data?['descripcion'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (descripcion != null) "descripcion": descripcion,
    };
  }
}
