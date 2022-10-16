import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/paciente.dart';

final db = FirebaseFirestore.instance;

Future<Paciente> getUserName(String email) async {
  var username = '';
  int edad = 0;
  var direccion = '';
  int dni = 0;
  var document = '';
  try {
    await db.collection("paciente").where("email", isEqualTo: email)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        username = doc.data()["nombre"];
        edad = doc.data()["edad"];
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_paciente"];
        document = doc.id;
      }
    });
  } catch (e) {
    print(e);
  }
  var paciente = Paciente(nombre: username, edad: edad, direccion: direccion, dni: dni, docid: document);
  return paciente;
}

CollectionReference solicitud = FirebaseFirestore.instance.collection("solicitud");

Future<void> crearSolicitud(String direccion, int dni, int edad, String nombre, String sintomas, Timestamp fecha_hora){
  return solicitud
      .add({
    'direccion': direccion,
    'dni_paciente': dni,
    'edad': edad,
    'nombre': nombre,
    'sintomas': sintomas,
    'fecha_hora': fecha_hora
  })
      .then((value) => print('Solicitud generada correctamente.'))
      .catchError((error) => print('Solicitud no fue generada'));
}

CollectionReference cita = FirebaseFirestore.instance.collection("cita");

Future<void> crearcita(String diagnostico, int codigo_paciente, int codigo_medico, Timestamp fecha){
  return cita
      .add({
    'Diagnostico': diagnostico,
    'codigo_paciente': codigo_paciente,
    'codigo_medico': codigo_medico,
    'fecha': fecha
  })
      .then((value) => print('Cita generada correctamente.'))
      .catchError((error) => print('Cita no fue generada'));
}

CollectionReference paciente = FirebaseFirestore.instance.collection("paciente");

Future<void> editarPaciente(String id, String nombre, int edad, String direccion){
  return paciente
      .doc(id)
      .update({
    'nombre': nombre,
    'edad': edad,
    'direccion': direccion,
  })
      .then((value) => print("Perfil de paciente actualizado correctamente"))
      .catchError((error) => print("Actualización fallida."));
}