// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/services/datos_paciente.dart';
import 'package:pry20220116/widgets/paciente/bottom_nav_bar_paciente.dart';
import '../../utilities/constraints.dart';

class PPerfil extends StatelessWidget {
  const PPerfil({Key? key}) : super(key: key);

  static String id = '/perfilPaciente';

  @override
  Widget build(BuildContext context) {
    return const PPerfilStf();
  }
}

class PPerfilStf extends StatefulWidget {
  const PPerfilStf({Key? key}) : super(key: key);

  @override
  _PPerfilState createState() => _PPerfilState();
}

class _PPerfilState extends State<PPerfilStf> {
  final _keyForm = GlobalKey<FormState>();
  final alergiaController = TextEditingController();
  final direccionController = TextEditingController();
  final dniController = TextEditingController();
  final edadController = TextEditingController();
  final correoController = TextEditingController();
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
    correoController.dispose();
    nombreController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<Paciente>(
            future: patientService.getPatientByUID(currentUser.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              alergiaController.text = snapshot.data!.alergia!;
              direccionController.text = snapshot.data!.direccion!;
              dniController.text = snapshot.data!.dni!;
              edadController.text = snapshot.data!.edad!;
              correoController.text = snapshot.data!.email!;
              nombreController.text = snapshot.data!.nombre!;
              telefonoController.text = snapshot.data!.telefono!;
              return Form(
                key: _keyForm,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image.network(
                          currentUser.photoURL!,
                          height: 60,
                        ),
                      ),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          readOnly: true,
                          controller: correoController,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Número de celular",
                          ),
                          validator: ((value) {
                            return validateNumber(
                                "Número de celular", 9, value!);
                          }),
                        ),
                      ),
                      //!Actualizar
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              patientService
                                  .editarPaciente(
                                      currentUser.uid,
                                      alergiaController.text,
                                      direccionController.text,
                                      dniController.text,
                                      edadController.text,
                                      nombreController.text,
                                      telefonoController.text)
                                  .then((value) => popUpExito(context))
                                  .onError(
                                    (error, stackTrace) =>
                                        popUpFallido(context),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 2.0, color: colorSecundario),
                            backgroundColor: colorPrincipal,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(150.0, 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "GUARDAR",
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             EditProfilePaciente(),
                      //       ),
                      //     );
                      //   },
                      //   child: const Text('Editar'),
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> popUpExito(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10.0),
        actionsPadding: const EdgeInsets.only(bottom: 10),
        title: const Text(
          'Perfil Actualizado',
          style: TextStyle(fontSize: 13.0),
        ),
        content: RichText(
          text: TextSpan(
            text: 'Su perfil fue actualizado correctamente.',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14.0),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "ACEPTAR",
              style: TextStyle(fontSize: 10.0, color: Colors.blue),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PBottomNavBar()),
              );
            },
          )
        ],
      );
    },
  );
}

Future<void> popUpFallido(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10.0),
        actionsPadding: const EdgeInsets.only(bottom: 10),
        title: const Text(
          'Algo salió mal',
          style: TextStyle(fontSize: 13.0),
        ),
        content: RichText(
          text: TextSpan(
            text:
                'Su perfil no fue actualizado. Por favor, inténtelo nuevamente.',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14.0),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "ACEPTAR",
              style: TextStyle(fontSize: 10.0, color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
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
