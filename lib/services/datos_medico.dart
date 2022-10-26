import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/medico.dart';

final medicodb = FirebaseFirestore.instance.collection("medico");

Future<Medico> getDataMedico(String correo) async {
  var direccion = '';
  int dni = 0;
  int edad = 0;
  var email = '';
  var especialidad = '';
  var nombre = '';
  int numeroCelular = 0;
  int aniosTrabajados = 0;
  var uid = '';
  var urlImage = '';

  try {
    await medicodb.where("email", isEqualTo: correo).get().then((event) {
      for (var doc in event.docs) {
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_medico"];
        edad = doc.data()["edad"];
        email = doc.data()["email"];
        especialidad = doc.data()["especialidad"];
        nombre = doc.data()["nombre"];
        numeroCelular = doc.data()["numero"];
        aniosTrabajados = doc.data()["tiempo_trabajado"];
        uid = doc.data()["uid"];
        urlImage = doc.data()["urlImage"];
      }
    });
  } catch (e) {
    //print(e);
  }
  var medico = Medico(
      direccion: direccion,
      dni: dni,
      edad: edad,
      email: email,
      especialidad: especialidad,
      nombre: nombre,
      numeroCelular: numeroCelular,
      aniosTrabajados: aniosTrabajados,
      uid: uid,
      urlImage: urlImage);
  return medico;
}

Future<Medico> getMedicoByUID(String medicoUID) async {
  var direccion = '';
  int dni = 0;
  int edad = 0;
  var email = '';
  var especialidad = '';
  var nombre = '';
  int numeroCelular = 0;
  int aniosTrabajados = 0;
  var uid = '';
  var urlImage = '';

  try {
    await medicodb.where("uid", isEqualTo: medicoUID).get().then((event) {
      for (var doc in event.docs) {
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_medico"];
        edad = doc.data()["edad"];
        email = doc.data()["email"];
        especialidad = doc.data()["especialidad"];
        nombre = doc.data()["nombre"];
        numeroCelular = doc.data()["numero"];
        aniosTrabajados = doc.data()["tiempo_trabajado"];
        uid = doc.data()["uid"];
        urlImage = doc.data()["urlImage"];
      }
    });
  } catch (e) {
    //print(e);
  }
  var medico = Medico(
      direccion: direccion,
      dni: dni,
      edad: edad,
      email: email,
      especialidad: especialidad,
      nombre: nombre,
      numeroCelular: numeroCelular,
      aniosTrabajados: aniosTrabajados,
      uid: uid,
      urlImage: urlImage);
  return medico;
}

Future<Medico> getMedicoByName(String medicoNombre) async {
  var direccion = '';
  int dni = 0;
  int edad = 0;
  var email = '';
  var especialidad = '';
  var nombre = '';
  int numeroCelular = 0;
  int aniosTrabajados = 0;
  var uid = '';
  var urlImage = '';

  try {
    await medicodb.where("nombre", isEqualTo: medicoNombre).get().then((event) {
      for (var doc in event.docs) {
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_medico"];
        edad = doc.data()["edad"];
        email = doc.data()["email"];
        especialidad = doc.data()["especialidad"];
        nombre = doc.data()["nombre"];
        numeroCelular = doc.data()["numero"];
        aniosTrabajados = doc.data()["tiempo_trabajado"];
        uid = doc.data()["uid"];
        urlImage = doc.data()["urlImage"];
      }
    });
  } catch (e) {
    //print(e);
  }
  var medico = Medico(
      direccion: direccion,
      dni: dni,
      edad: edad,
      email: email,
      especialidad: especialidad,
      nombre: nombre,
      numeroCelular: numeroCelular,
      aniosTrabajados: aniosTrabajados,
      uid: uid,
      urlImage: urlImage);
  return medico;
}

Future<void> editarMedico(
    String id, String nombre, int edad, int dni, String direccion) {
  return medicodb
      .doc(id)
      .update({
        'nombre': nombre,
        'edad': edad,
        'dni_medico': dni,
        'direccion': direccion,
      })
      .then(
          (value) => {}) //print("Perfil de médico actualizado correctamente"))
      .catchError((error) => {}); //print("Actualización fallida."));
}
