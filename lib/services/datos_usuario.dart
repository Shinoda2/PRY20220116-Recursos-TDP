import 'package:cloud_firestore/cloud_firestore.dart';

final userDB = FirebaseFirestore.instance.collection("usuario");

Future<void> crearMedico(String nombre, String uid, String rol) {
  return userDB
      .doc(uid)
      .set({
        'nombre': nombre,
        'uid': uid,
        'rol': rol,
      })
      .then((value) => {})
      .catchError((error) => {});
}