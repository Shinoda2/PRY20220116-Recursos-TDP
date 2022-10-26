import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? nombre;
  final String? uid;
  final String? rol;

  const Usuario({
    this.nombre,
    this.uid,
    this.rol,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      nombre: data?['nombre'],
      uid: data?['uid'],
      rol: data?['rol'],
    );
  }
}
