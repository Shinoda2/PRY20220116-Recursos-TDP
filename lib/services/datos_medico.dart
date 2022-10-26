import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

Future<void> crearMedico(
    String direccion,
    String dni,
    String edad,
    String email,
    String especialidad,
    String nombre,
    String numeroCelular,
    String aniosTrabajados,
    String contrasenia) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: contrasenia);

  medicodb
      .doc(userCredential.user!.uid)
      .set({
        'direccion': direccion,
        'dni_medico': int.parse(dni),
        'edad': int.parse(edad),
        'email': email,
        'especialidad': especialidad,
        'imagen':
            'https://firebasestorage.googleapis.com/v0/b/wisha-database.appspot.com/o/female%20doctor.jpeg?alt=media&token=1d343adc-e71c-4917-9e85-9ccbbc7660b3',
        'nombre': nombre,
        'numero': int.parse(numeroCelular),
        'tiempo_trabajado': int.parse(aniosTrabajados),
        'uid': userCredential.user!.uid,
        'urlImage':
            'https://firebasestorage.googleapis.com/v0/b/wisha-database.appspot.com/o/female%20doctor.jpeg?alt=media&token=1d343adc-e71c-4917-9e85-9ccbbc7660b3'
      })
      .then((value) => {}) //print('Cita generada correctamente.'))
      .catchError((error) => {}); //print('Cita no fue generada'));
}

Future<List<Medico>> getAllMedics() async {
  List<Medico> listaMedicos = [];
  Medico medico;

  try {
    await medicodb.get().then((event) {
      for (var doc in event.docs) {
        medico = Medico(
          direccion: doc.data()["direccion"],
          dni: doc.data()["dni_medico"],
          edad: doc.data()["edad"],
          email: doc.data()["email"],
          especialidad: doc.data()["especialidad"],
          nombre: doc.data()["nombre"],
          numeroCelular: doc.data()["numero"],
          aniosTrabajados: doc.data()["tiempo_trabajado"],
          uid: doc.data()["uid"],
          urlImage: doc.data()["urlImage"],
        );
        listaMedicos.add(medico);
      }
    });
  } catch (e) {
    // print(e);
  }

  return listaMedicos;
}
