import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/medico.dart';

final db = FirebaseFirestore.instance;

Future<Medico> getDataMedico(String correo) async {
  var username = '';
  int edad = 0;
  var direccion = '';
  int dni = 0;
  var document = '';
  try {
    await db
        .collection("medico")
        .where("email", isEqualTo: correo)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        username = doc.data()["nombre"];
        edad = doc.data()["edad"];
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_medico"];
        document = doc.id;
      }
    });
  } catch (e) {
    //print(e);
  }
  var medico = Medico(
      nombre: username,
      edad: edad,
      direccion: direccion,
      dni: dni,
      docid: document);
  return medico;
}

CollectionReference medico = FirebaseFirestore.instance.collection("medico");

Future<void> editarMedico(
    String id, String nombre, int edad, String direccion) {
  return medico
      .doc(id)
      .update({
        'nombre': nombre,
        'edad': edad,
        'direccion': direccion,
      })
      .then(
          (value) => {}) //print("Perfil de médico actualizado correctamente"))
      .catchError((error) => {}); //print("Actualización fallida."));
}
