import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/usuario.dart';

final userDB = FirebaseFirestore.instance.collection("usuario");

class AdminService {
  Future<void> crearUsuario(String email, String uid, String rol) {
    return userDB
        .doc(uid)
        .set({
          'email': email,
          'uid': uid,
          'rol': rol,
        })
        .then((value) => {})
        .catchError((error) => {});
  }

  Future<Usuario> getUserByUID(String userUID) async {
    var email = '';
    var uid = '';
    var rol = '';

    try {
      await userDB.where('uid', isEqualTo: userUID).get().then((event) {
        for (var doc in event.docs) {
          email = doc.data()["email"];
          uid = doc.data()["uid"];
          rol = doc.data()["rol"];
        }
      });
    } catch (e) {}
    var usuario = Usuario(email: email, uid: uid, rol: rol);
    return usuario;
  }
}
