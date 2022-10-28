import 'package:flutter/material.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/utilities/constraints.dart';

class PerfilMedico extends StatefulWidget {
  final Medico medico;

  const PerfilMedico({Key? key, required this.medico}) : super(key: key);

  static String id = '/perfilMedico';

  @override
  State<PerfilMedico> createState() => _PerfilMedicoState();
}

class _PerfilMedicoState extends State<PerfilMedico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Perfil de médico", style: kTituloCabezera),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    widget.medico.urlImage!,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Nombre Completo: ${widget.medico.nombre}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Email: ${widget.medico.email}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Especialidad: ${widget.medico.especialidad}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Años de experiencia: ${widget.medico.aniosTrabajados}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Teléfono: ${widget.medico.numeroCelular}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Edad: ${widget.medico.edad}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'DNI: ${widget.medico.dni}',
                style: kHintText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Dirección: ${widget.medico.direccion}',
                style: kHintText,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
