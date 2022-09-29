import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/paciente.dart';

final db = FirebaseFirestore.instance;

Future<Paciente> getUserName(String email) async {
  var username = '';
  int edad = 0;
  var direccion = '';
  int dni = 0;
  try {
    await db.collection("paciente").where("email", isEqualTo: email)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        username = doc.data()["nombre"];
        edad = doc.data()["edad"];
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_paciente"];
      }
    });
  } catch (e) {
    print(e);
  }
  var paciente = Paciente(nombre: username, edad: edad, direccion: direccion, dni: dni);
  return paciente;
}

CollectionReference solicitud = FirebaseFirestore.instance.collection("solicitud");

Future<void> crearSolicitud(String direccion, int dni, int edad, String nombre, String sintomas){
  return solicitud
      .add({
    'direccion': direccion,
    'dni_paciente': dni,
    'edad': edad,
    'nombre': nombre,
    'sintomas': sintomas,
  })
      .then((value) => print('Solicitud generada correctamente.'))
      .catchError((error) => print('Solicitud no fue generada'));
}