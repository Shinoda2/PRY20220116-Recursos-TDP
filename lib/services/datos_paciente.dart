import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/paciente/auth/register.dart';
import 'package:pry20220116/screens/shared/inicio.dart';
import 'package:pry20220116/services/datos_usuario.dart';
import 'package:pry20220116/widgets/paciente/bottom_nav_bar_paciente.dart';

final pacientedb = FirebaseFirestore.instance.collection("paciente");
final citaDB = FirebaseFirestore.instance.collection("cita");

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class PatientService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(credential).then((value) async {
        try {
          final docRef = pacientedb.doc(value.user!.uid);
          await docRef.get().then(
            (DocumentSnapshot doc) async {
              if (doc.exists) {
                Navigator.pushNamedAndRemoveUntil(
                    context, PBottomNavBar.id, (_) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegistrarPacienteViewPage.id, (_) => false);
              }
            },
          );
        } catch (e) {}
      });
    } catch (e) {}
  }

  void signOutPatient(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, StartPage.id, (_) => false);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void createPatient(
      String alergia,
      String direccion,
      String dni,
      String edad,
      String email,
      String nombre,
      String telefono,
      String uid,
      String urlImage,
      BuildContext context) async {
    var paciente = Paciente(
        alergia: alergia,
        direccion: direccion,
        dni: dni,
        edad: edad,
        email: email,
        nombre: nombre,
        telefono: telefono,
        uid: uid,
        urlImage: urlImage);

    AdminService adminService = AdminService();
    adminService.crearUsuario(email, uid, "paciente");
    final docRef = pacientedb
        .withConverter(
          fromFirestore: Paciente.fromFirestore,
          toFirestore: (Paciente paciente, options) => paciente.toFirestore(),
        )
        .doc(uid);
    await docRef
        .set(paciente)
        .then((value) => Navigator.pushNamed(context, PBottomNavBar.id));
  }

  Future<Paciente> getPatientByUID(String pacienteUID) async {
    var alergia = '';
    var direccion = '';
    var dni = '';
    var edad = '';
    var email = '';
    var nombre = '';
    var telefono = '';
    var uid = '';
    var urlImage = '';

    try {
      await pacientedb.where('uid', isEqualTo: pacienteUID).get().then((event) {
        for (var doc in event.docs) {
          alergia = doc.data()["alergia"];
          direccion = doc.data()["direccion"];
          dni = doc.data()["dni"];
          edad = doc.data()["edad"];
          email = doc.data()["email"];
          nombre = doc.data()["nombre"];
          telefono = doc.data()["telefono"];
          uid = doc.data()["uid"];
          urlImage = doc.data()["urlImage"];
        }
      });
    } catch (e) {}
    var paciente = Paciente(
        alergia: alergia,
        direccion: direccion,
        dni: dni,
        edad: edad,
        email: email,
        nombre: nombre,
        telefono: telefono,
        uid: uid,
        urlImage: urlImage);
    return paciente;
  }

  Future<List<Paciente>> getAllPatients() async {
    List<Paciente> listaPacientes = [];
    Paciente paciente;

    try {
      await pacientedb.get().then((event) {
        for (var doc in event.docs) {
          paciente = Paciente(
              alergia: doc.data()["alergia"],
              direccion: doc.data()["direccion"],
              dni: doc.data()["dni"],
              edad: doc.data()["edad"],
              email: doc.data()["email"],
              nombre: doc.data()["nombre"],
              telefono: doc.data()["telefono"],
              uid: doc.data()["uid"],
              urlImage: doc.data()["urlImage"]);
          listaPacientes.add(paciente);
        }
      });
    } catch (e) {
      // print(e);
    }

    return listaPacientes;
  }

  Future<void> editarPaciente(String id, String alergia, String direccion,
      String dni, String edad, String nombre, String telefono) {
    return pacientedb
        .doc(id)
        .update({
          'alergia': alergia,
          'direccion': direccion,
          'dni': dni,
          'edad': edad,
          'nombre': nombre,
          'telefono': telefono,
        })
        .then((value) =>
            {}) //print("Perfil de paciente actualizado correctamente"))
        .catchError((error) => {}); //print("Actualización fallida."));
  }

  Future<List<Paciente>> getPatientListByMedicUID(String medicUID) async {
    List<String> listaPacientesUID = [];
    List<Paciente> listaPacientes = [];
    Paciente paciente;
    String pacienteUID;

    try {
      await citaDB
          .where("codigo_medico", isEqualTo: medicUID)
          .get()
          .then((event) {
        for (var doc in event.docs) {
          pacienteUID = doc.data()["codigo_paciente"];
          listaPacientesUID.add(pacienteUID);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    listaPacientesUID = listaPacientesUID.toSet().toList();
    for (var i = 0; i < listaPacientesUID.length; i++) {
      paciente = await getPatientByUID(listaPacientesUID[i]);
      listaPacientes.add(paciente);
    }

    return listaPacientes;
  }
}
