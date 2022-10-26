import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/paciente.dart';

final pacientedb = FirebaseFirestore.instance.collection("paciente");

Future<Paciente> getDataPaciente(String correo) async {
  var alergia = '';
  var codigo_medico = '';
  var direccion = '';
  int dni = 0;
  int edad = 0;
  var email = '';
  var nombre = '';
  int numero_telefono = 0;
  var uid = '';
  var urlImage = '';

  try {
    await pacientedb.where("email", isEqualTo: correo).get().then((event) {
      for (var doc in event.docs) {
        alergia = doc.data()["alergia"];
        codigo_medico = doc.data()["codigo_medico"];
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_paciente"];
        edad = doc.data()["edad"];
        email = doc.data()["email"];
        nombre = doc.data()["nombre"];
        numero_telefono = doc.data()["numero_telefono"];
        uid = doc.data()["uid"];
        urlImage = doc.data()["urlImage"];
      }
    });
  } catch (e) {
    //print(e);
  }
  var paciente = Paciente(
      alergia: alergia,
      codigo_medico: codigo_medico,
      direccion: direccion,
      dni: dni,
      edad: edad,
      email: email,
      nombre: nombre,
      numero_telefono: numero_telefono,
      uid: uid,
      urlImage: urlImage);
  return paciente;
}

Future<Paciente> getDataPacienteByUID(String pacienteUID) async {
  var alergia = '';
  var codigo_medico = '';
  var direccion = '';
  int dni = 0;
  int edad = 0;
  var email = '';
  var nombre = '';
  int numero_telefono = 0;
  var uid = '';
  var urlImage = '';

  try {
    await pacientedb
        .where("uid", isEqualTo: pacienteUID)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        alergia = doc.data()["alergia"];
        codigo_medico = doc.data()["codigo_medico"];
        direccion = doc.data()["direccion"];
        dni = doc.data()["dni_paciente"];
        edad = doc.data()["edad"];
        email = doc.data()["email"];
        nombre = doc.data()["nombre"];
        numero_telefono = doc.data()["numero_telefono"];
        uid = doc.data()["uid"];
        urlImage = doc.data()["urlImage"];
      }
    });
  } catch (e) {
    //print(e);
  }
  var paciente = Paciente(
      alergia: alergia,
      codigo_medico: codigo_medico,
      direccion: direccion,
      dni: dni,
      edad: edad,
      email: email,
      nombre: nombre,
      numero_telefono: numero_telefono,
      uid: uid,
      urlImage: urlImage);
  return paciente;
}

Future<void> editarPaciente(
    String id, String nombre, int edad, int dni, String direccion) {
  return pacientedb
      .doc(id)
      .update({
        'nombre': nombre,
        'edad': edad,
        'dni_paciente': dni,
        'direccion': direccion,
      })
      .then((value) =>
          {}) //print("Perfil de paciente actualizado correctamente"))
      .catchError((error) => {}); //print("Actualización fallida."));
}

//!

CollectionReference citaDB = FirebaseFirestore.instance.collection("cita");

Future<void> crearCita(
    String codigoPaciente,
    String codigoMedico,
    Timestamp fecha,
    String nombreMedico,
    String nombrePaciente,
    String sintoma) {
  String citaId = citaDB.doc().id;
  return citaDB
      .doc(citaId)
      .set({
        'citaId': citaId,
        'codigo_paciente': codigoPaciente,
        'codigo_medico': codigoMedico,
        'fecha': fecha,
        'isFinished': false,
        'nombre_medico': nombreMedico,
        'nombre_paciente': nombrePaciente,
        'sintoma': sintoma
      })
      .then((value) => {}) //print('Cita generada correctamente.'))
      .catchError((error) => {}); //print('Cita no fue generada'));
}
