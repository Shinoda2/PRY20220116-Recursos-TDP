// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/medico/perfil_paciente_medico.dart';
import 'package:pry20220116/services/datos_paciente.dart';

import '../../utilities/constraints.dart';

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
      future: getPatientListByMedicUID(currentUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          return Center(child: Text("No hay pacientes registrados"));
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                Paciente paciente = snapshot.data![index];
                return CardPaciente(paciente: paciente);
              }),
            ),
          ),
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
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset('assets/image/icon.png'),
            ),
            title: Text(
              paciente.nombre!,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MPerfilPaciente(paciente: paciente),
              ),
            ),
          ),
          kLineaDivisora
        ],
      ),
    );
  }
}
