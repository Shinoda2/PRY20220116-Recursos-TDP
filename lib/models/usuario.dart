import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? email;
  final String? uid;
  final String? rol;

  const Usuario({
    this.email,
    this.uid,
    this.rol,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      email: data?['email'],
      uid: data?['uid'],
      rol: data?['rol'],
    );
  }
}
