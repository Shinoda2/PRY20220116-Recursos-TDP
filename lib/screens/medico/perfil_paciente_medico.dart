import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import '../../utilities/constraints.dart';

class MPerfilPaciente extends StatelessWidget {
  final Paciente paciente;
  const MPerfilPaciente({Key? key, required this.paciente}) : super(key: key);

  static String id = '/perfilPacienteMedico';

  @override
  Widget build(BuildContext context) {
    return MPerfilPacienteStf(paciente: paciente);
  }
}

class MPerfilPacienteStf extends StatefulWidget {
  final Paciente paciente;
  const MPerfilPacienteStf({Key? key, required this.paciente})
      : super(key: key);

  @override
  _MPerfilState createState() => _MPerfilState();
}

class _MPerfilState extends State<MPerfilPacienteStf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nombre Paciente", style: kTituloCabezera),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/image/icon.png',
                height: 120,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Nombre Completo: ${widget.paciente.nombre}',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Edad: ${widget.paciente.edad}',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'DNI: ${widget.paciente.dni}',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Dirección: ${widget.paciente.direccion}',
            ),
          ),
        ],
      ),
    );
  }
}
