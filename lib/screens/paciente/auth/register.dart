// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pry20220116/services/datos_paciente.dart';

class RegistrarPacienteViewPage extends StatefulWidget {
  const RegistrarPacienteViewPage({Key? key}) : super(key: key);

  static String id = '/registrarPaciente';

  @override
  State<RegistrarPacienteViewPage> createState() =>
      _RegistrarPacienteViewPageState();
}

class _RegistrarPacienteViewPageState extends State<RegistrarPacienteViewPage> {
  final _keyForm = GlobalKey<FormState>();
  final alergiaController = TextEditingController();
  final direccionController = TextEditingController();
  final dniController = TextEditingController();
  final edadController = TextEditingController();
  final emailController = TextEditingController();
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!;
  final patientService = PatientService();

  @override
  void dispose() {
    alergiaController.dispose();
    direccionController.dispose();
    dniController.dispose();
    edadController.dispose();
    emailController.dispose();
    nombreController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = currentUser.email!;
    nombreController.text = currentUser.displayName!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar paciente"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                //!Alergia
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: alergiaController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Alergia",
                    ),
                    validator: ((value) {
                      return validateText("Alergia", value!);
                    }),
                  ),
                ),
                //!Direccion
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: direccionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Dirección",
                    ),
                    validator: ((value) {
                      return validateText("Dirección", value!);
                    }),
                  ),
                ),
                //!DNI
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: dniController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "DNI",
                    ),
                    validator: ((value) {
                      return validateNumber("DNI", 8, value!);
                    }),
                  ),
                ),
                //!Edad
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: edadController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Edad",
                    ),
                    validator: ((value) {
                      return validateNumber("Edad", 0, value!);
                    }),
                  ),
                ),
                //!Email
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: ((value) {
                      return validateText("Email", value!);
                    }),
                  ),
                ),
                //!Nombre
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nombreController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Nombre completo",
                    ),
                    validator: ((value) {
                      return validateText("Nombre completo", value!);
                    }),
                  ),
                ),
                //!Telefono
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: telefonoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Número de celular",
                    ),
                    validator: ((value) {
                      return validateNumber("Número de celular", 9, value!);
                    }),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      patientService.createPatient(
                          alergiaController.text,
                          direccionController.text,
                          dniController.text,
                          edadController.text,
                          emailController.text,
                          nombreController.text,
                          telefonoController.text,
                          currentUser.uid,
                          currentUser.photoURL!,
                          context);
                    }
                    //Navigator.pushNamed(context, AdminHome.id);
                  },
                  child: Text("Crear"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateText(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  if (value.length < 3) {
    return '$label debe tener mínimo 3 caracteres';
  }
  return null;
}

String? validateNumber(String label, int length, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  if (length != 0) {
    if (value.length != length) {
      return '$label no es válido';
    }
  }
  return null;
}
