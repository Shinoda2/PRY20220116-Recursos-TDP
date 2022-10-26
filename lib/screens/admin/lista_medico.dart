// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/services/datos_medico.dart';

class ListaMedicoPage extends StatefulWidget {
  const ListaMedicoPage({super.key});

  @override
  State<ListaMedicoPage> createState() => _ListaMedicoPageState();
}

class _ListaMedicoPageState extends State<ListaMedicoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de médicos"),
      ),
      body: Center(
        child: FutureBuilder<List<Medico>>(
          future: getAllMedics(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No hay médicos registrados"));
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  Medico medico = snapshot.data![index];
                  return MedicCardItem(medico: medico);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MedicCardItem extends StatelessWidget {
  const MedicCardItem({super.key, required this.medico});
  final Medico medico;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            child: Image.network(medico.urlImage!),
          ),
          title: Text(
            medico.nombre!,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Especialidad: ${medico.especialidad!}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              Text(
                "Años de experiencia: ${medico.aniosTrabajados!}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          //onTap: () => Navigator.push(
          //  context,
          //  MaterialPageRoute(
          //    builder: (context) => MPerfilPaciente(paciente: paciente),
          //  ),
          //),
        ),
      ),
    );
  }
}
