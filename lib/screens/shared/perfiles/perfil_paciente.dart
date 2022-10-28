import 'package:flutter/material.dart';
import 'package:pry20220116/models/paciente.dart';
import '../../../utilities/constraints.dart';

class PerfilPaciente extends StatefulWidget {
  final Paciente paciente;

  const PerfilPaciente({Key? key, required this.paciente}) : super(key: key);

  static String id = '/perfilPaciente';

  @override
  State<PerfilPaciente> createState() => _PerfilPacienteState();
}

class _PerfilPacienteState extends State<PerfilPaciente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de paciente", style: kTituloCabezera),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      widget.paciente.urlImage!,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Nombre Completo: ${widget.paciente.nombre}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Edad: ${widget.paciente.edad}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'DNI: ${widget.paciente.dni}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Dirección: ${widget.paciente.direccion}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Alergia: ${widget.paciente.alergia}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Email: ${widget.paciente.email}',
                  style: kHintText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Teléfono: ${widget.paciente.telefono}',
                  style: kHintText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
