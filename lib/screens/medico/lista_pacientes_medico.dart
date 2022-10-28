// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/shared/perfiles/perfil_paciente.dart';
import 'package:pry20220116/services/datos_paciente.dart';

import '../../utilities/constraints.dart';

class MiListaPacientes extends StatefulWidget {
  const MiListaPacientes({super.key});

  @override
  State<MiListaPacientes> createState() => _MiListaPacientesState();
}

class _MiListaPacientesState extends State<MiListaPacientes> {
  var currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final patientService = PatientService();
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Paciente>>(
      future: patientService.getPatientListByMedicUID(currentUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          return Center(child: Text("No hay pacientes registrados"));
        }
        return Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Buscar...',
                          hintStyle: kHintText,
                          labelStyle: kHintText,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _search = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Material(
                    child: IconButton(
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        //navigateResult(context);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    Paciente paciente = snapshot.data![index];
                    return CardPaciente(paciente: paciente);
                  }),
                ),
              ),
            ],
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 30,
                child: Image.network(paciente.urlImage!),
              ),
              title: Text(
                paciente.nombre!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilPaciente(paciente: paciente),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
