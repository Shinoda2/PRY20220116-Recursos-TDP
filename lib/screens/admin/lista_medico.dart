// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/screens/shared/perfiles/perfil_medico.dart';
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
            backgroundImage: NetworkImage(medico.urlImage!),
          ),
          title: Text(
            medico.nombre!,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            medico.email!,
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
              builder: (context) => PerfilMedico(medico: medico),
            ),
          ),
        ),
      ),
    );
  }
}
