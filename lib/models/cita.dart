import 'package:cloud_firestore/cloud_firestore.dart';

class Cita {
  final String? diagnostico;
  final int? codigo_medico;
  final int? codigo_paciente;
  final Timestamp? fecha;

  Cita({
    required this.diagnostico,
    required this.codigo_medico,
    required this.codigo_paciente,
    required this.fecha,
  });

  void ga() {
    FirebaseFirestore.instance
        .collection("cities")
        .where("capital", isEqualTo: true)
        .get()
        .then(
          (res) => print("Successfully completed"),
          onError: (e) => print("Error completing: $e"),
        );
  }

  factory Cita.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cita(
      diagnostico: data?['Diagnostico'],
      codigo_medico: data?['codigo_medico'],
      codigo_paciente: data?['codigo_paciente'],
      fecha: data?['fecha'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (diagnostico != null) "Diagnostico": diagnostico,
      if (codigo_medico != null) "codigo_medico": codigo_medico,
      if (codigo_paciente != null) "codigo_paciente": codigo_paciente,
      if (fecha != null) "fecha": fecha,
    };
  }
}
