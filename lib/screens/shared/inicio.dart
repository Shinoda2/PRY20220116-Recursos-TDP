import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/analisis_medico.dart';

import '../../utilities/constraints.dart';
import '../medico/login_medico.dart';
import '../paciente/login_paciente.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: colorPrincipal),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text("WISHA", style: kLogo),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PLogin.id);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 2.0, color: colorSecundario),
                  backgroundColor: colorPrincipal,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(180.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("PACIENTE"),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MLogin.id);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 2.0, color: colorSecundario),
                  backgroundColor: colorPrincipal,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(180.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("MÉDICO"),
              ),
            ),
          ),
          Flexible(
            child: Image.asset('assets/image/medico.png'),
          )
        ],
      ),
    );
  }
}
