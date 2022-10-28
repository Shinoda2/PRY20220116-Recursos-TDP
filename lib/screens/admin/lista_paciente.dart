// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/shared/perfiles/perfil_paciente.dart';
import 'package:pry20220116/services/datos_paciente.dart';

class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({super.key});

  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}

class _ListaPacientePageState extends State<ListaPacientePage> {
  final patientService = PatientService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de pacientes"),
      ),
      body: Center(
        child: FutureBuilder<List<Paciente>>(
          future: patientService.getAllPatients(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No hay pacientes registrados"));
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  Paciente paciente = snapshot.data![index];
                  return PatientCardItem(paciente: paciente);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PatientCardItem extends StatelessWidget {
  const PatientCardItem({super.key, required this.paciente});
  final Paciente paciente;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(paciente.urlImage!),
          ),
          title: Text(
            paciente.nombre!,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            paciente.email!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          trailing: Icon(
            Icons.arrow_right_rounded,
            color: Colors.black,
            size: 40,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PerfilPaciente(paciente: paciente),
            ),
          ),
        ),
      ),
    );
  }
}
