// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pry20220116/services/datos_paciente.dart';
import 'package:pry20220116/utilities/constraints.dart';

class LoginPacientePage extends StatefulWidget {
  const LoginPacientePage({Key? key}) : super(key: key);

  static String id = '/loginPaciente';

  @override
  State<LoginPacientePage> createState() => _LoginPacientePageState();
}

class _LoginPacientePageState extends State<LoginPacientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  loginPaciente(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('INICIAR SESIÓN', style: kTitulo1),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorPrincipal,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 2.0,
                          color: colorSecundario,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/image/google_logo.png",
                            width: 30,
                          ),
                          Text(
                            "Ingresar con Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Image.asset('assets/image/deaf_person.png'),
            ),
          ],
        ),
      ),
    );
  }
}

PatientService patientService = PatientService();

void loginPaciente(BuildContext context) {
  patientService.signInWithGoogle(context);
}
