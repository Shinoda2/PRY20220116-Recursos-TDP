import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/cita.dart';

final citaDB = FirebaseFirestore.instance.collection("cita");

class AppointmentService {
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
        .then((value) => {})
        .catchError((error) => {});
  }

  Future<Cita> getCitaByUID(String citaUID) async {
    var citaId = '';
    var codigoPaciente = '';
    var codigoMedico = '';
    Timestamp fecha = Timestamp.fromDate(DateTime.now());
    var isFinished = false;
    var nombreMedico = '';
    var nombrePaciente = '';
    var sintoma = '';

    try {
      await citaDB.where("citaId", isEqualTo: citaUID).get().then((event) {
        for (var doc in event.docs) {
          citaId = doc.data()["citaId"];
          codigoPaciente = doc.data()["codigo_paciente"];
          codigoMedico = doc.data()["codigo_medico"];
          fecha = doc.data()["fecha"];
          isFinished = doc.data()["isFinished"];
          nombreMedico = doc.data()["nombre_medico"];
          nombrePaciente = doc.data()["nombre_paciente"];
          sintoma = doc.data()["sintoma"];
        }
      });
    } catch (e) {
      //print(e);
    }
    var cita = Cita(
        sintoma: sintoma,
        citaId: citaId,
        codigo_medico: codigoMedico,
        codigo_paciente: codigoPaciente,
        fecha: fecha,
        nombre_medico: nombreMedico,
        nombre_paciente: nombrePaciente,
        isFinished: isFinished);
    return cita;
  }

  Future<void> finalizarCita(String id) {
    return citaDB
        .doc(id)
        .update({
          'isFinished': true,
        })
        .then((value) => {})
        .catchError((error) => {});
  }

  Future<void> editarCita(String id, Timestamp fecha) {
    return citaDB
        .doc(id)
        .update({
          'fecha': fecha,
        })
        .then((value) => {})
        .catchError((error) => {});
  }
}
