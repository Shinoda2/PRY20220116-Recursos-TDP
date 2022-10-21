import 'package:flutter/material.dart';
import 'package:pry20220116/models/lista_pacientes.dart';
import 'package:pry20220116/screens/medico/perfil_paciente_medico.dart';
import '../../utilities/constraints.dart';

class MListaPacientes extends StatefulWidget {
  const MListaPacientes({super.key});

  @override
  _MListaPacientesState createState() => _MListaPacientesState();
}

class _MListaPacientesState extends State<MListaPacientes> {
  List<Patient> patients = Patient.generatePatient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) => PatientCard(patients[index]),
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard(this.patient, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MPerfilPaciente(),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 30,
                child: Image.asset(patient.icon),
              ),
              title: Text(
                patient.name,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              // subtitle: Row(
              //   children: [
              //     Icon(Icons.done_all),
              //     SizedBox(
              //       width: 3,
              //     ),
              //     Text(
              //       '${patient.currentMessage}',
              //       style: TextStyle(
              //         fontSize: 13,
              //       ),
              //     )
              //   ],
              // ),
              // trailing: Text('${patient.time}'),
            ),
          ),
          kLineaDivisora,
        ],
      ),
    );
  }
}
