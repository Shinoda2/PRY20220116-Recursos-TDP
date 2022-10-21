import 'package:flutter/material.dart';
import '../../utilities/constraints.dart';

class MPerfilPaciente extends StatelessWidget {
  const MPerfilPaciente({Key? key}) : super(key: key);

  static String id = '/perfilPacienteMedico';

  @override
  Widget build(BuildContext context) {
    return const MPerfilPacienteStf();
  }
}

class MPerfilPacienteStf extends StatefulWidget {
  const MPerfilPacienteStf({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
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
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Nombre Completo: ',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Edad: ',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'DNI: ',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Dirección: ',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
