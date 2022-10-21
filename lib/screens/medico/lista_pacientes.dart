// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/medico/perfil_paciente_medico.dart';
import 'package:pry20220116/services/datos_paciente.dart';

class MiListaPacientes extends StatefulWidget {
  const MiListaPacientes({super.key});

  @override
  State<MiListaPacientes> createState() => _MiListaPacientesState();
}

class _MiListaPacientesState extends State<MiListaPacientes> {
  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Paciente>>(
      future: getListaGestantes(currentUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          return Center(child: Text("No hay pacientes registrados"));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: ((context, index) {
            Paciente paciente = snapshot.data![index];
            return CardPaciente(paciente: paciente);
          }),
        );
      },
    );
  }
}

class CardPaciente extends StatelessWidget {
  const CardPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset('assets/image/icon.png'),
            ),
            title: Text(paciente.nombre!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MPerfilPaciente(paciente: paciente),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Paciente>> getListaGestantes(String codigoMedico) async {
  List<Paciente> listaPacientes = [];
  Paciente paciente;

  try {
    await pacientedb
        .where("codigo_medico", isEqualTo: codigoMedico)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        paciente = Paciente(
            alergia: doc.data()["alergia"],
            codigo_medico: doc.data()["codigo_medico"],
            direccion: doc.data()["direccion"],
            dni: doc.data()["dni_paciente"],
            edad: doc.data()["edad"],
            email: doc.data()["email"],
            nombre: doc.data()["nombre"],
            numero_telefono: doc.data()["numero_telefono"],
            uid: doc.data()["uid"]);
        listaPacientes.add(paciente);
      }
    });
  } catch (e) {
    // print(e);
  }

  return listaPacientes;
}
