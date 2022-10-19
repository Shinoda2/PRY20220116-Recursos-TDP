import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/services/datos-paciente.dart';

import '../../utilities/constraints.dart';
import '../camera_screen.dart';

class PSolicitud extends StatefulWidget {
  const PSolicitud({Key? key}) : super(key: key);

  @override
  State<PSolicitud> createState() => _PSolicitud();
}

final db = FirebaseFirestore.instance;

class _PSolicitud extends State<PSolicitud> {
  final _keyForm = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final edadController = TextEditingController();
  final direccionController = TextEditingController();
  final sintomasController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    direccionController.dispose();
    sintomasController.dispose();
    super.dispose();
  }

  var correo = FirebaseAuth.instance.currentUser!.email!;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Future<void> navigateResult(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      ).then((value) {
        sintomasController.text += value;
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: FutureBuilder<Paciente>(
            future: getUserName(correo),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case (ConnectionState.waiting):
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case (ConnectionState.done):
                  nombreController.text = snapshot.data!.nombre!;
                  edadController.text = snapshot.data!.edad!.toString();
                  direccionController.text = snapshot.data!.direccion!;
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text('SOLICITUD DE CITAS', style: kTitulo1),
                      ),
                      Form(
                        key: _keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextWidget(
                              controlador: nombreController,
                              formatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z á-ú ]")),
                              ],
                              label: 'Nombre Completo',
                              inputType: TextInputType.text,
                              validacion: (value) {
                                return validarNombre("Nombre Completo", value!);
                              },
                              readOnly: true,
                              maxLines: 1,
                            ),
                            InputTextWidget(
                              controlador: edadController,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              label: 'Edad',
                              inputType: TextInputType.number,
                              validacion: (value) {
                                return validarEdad(value!);
                              },
                              readOnly: true,
                              maxLines: 1,
                            ),
                            InputTextWidget(
                              controlador: direccionController,
                              formatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z á-ú 0-9 .-]")),
                              ],
                              label: 'Dirección',
                              inputType: TextInputType.text,
                              validacion: (value) {
                                return validarTexto("Dirección", value!);
                              },
                              readOnly: true,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 240.0,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      maxLines: null,
                                      autocorrect: true,
                                      style: const TextStyle(fontSize: 12.0),
                                      readOnly: false,
                                      controller: sintomasController,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-z A-Z á-ú 0-9 .-/]")),
                                      ],
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        border: OutlineInputBorder(),
                                        labelText: 'Síntomas',
                                        labelStyle: kSubTitulo1,
                                      ),
                                      validator: (value) {
                                        return validarTexto("Síntomas", value!);
                                      },
                                    ),
                                  ),
                                ),
                                Material(
                                  child: IconButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          child: const Text("ENVIAR"),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 2.0, color: colorSecundario),
                            backgroundColor: colorPrincipal,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(180.0, 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              crearcita(
                                sintomasController.text,
                                FirebaseAuth.instance.currentUser!.uid,
                                1,
                                Timestamp.fromDate(
                                  DateTime.now()
                                      .add(Duration(days: 8, hours: 14)),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return const Text('Algo salió mal.');
              }
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
          'Cita Registrada',
          style: TextStyle(fontSize: 13.0),
        ),
        content: RichText(
          text: TextSpan(
            text: 'Su cita se registró correctamente.',
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
              Navigator.of(context).popUntil(ModalRoute.withName("/"));
            },
            // onPressed: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (BuildContext context) => Solicitud()));
            // },
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
            text: 'Su cita no fue registrada. Por favor, inténtelo nuevamente.',
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

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    required this.controlador,
    required this.formatters,
    required this.label,
    required this.inputType,
    this.validacion,
    required this.readOnly,
    required this.maxLines,
  }) : super(key: key);

  final TextEditingController controlador;
  final TextInputType inputType;
  final List<TextInputFormatter> formatters;
  final String label;
  final FormFieldValidator<String>? validacion;
  final bool readOnly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300.0,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: maxLines,
          autocorrect: true,
          style: const TextStyle(fontSize: 12.0),
          readOnly: readOnly,
          controller: controlador,
          keyboardType: inputType,
          inputFormatters: formatters,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: const OutlineInputBorder(),
            labelText: label,
            labelStyle: kSubTitulo1,
          ),
          validator: validacion,
        ),
      ),
    );
  }
}

String? validarNombre(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  if (value.length < 3) {
    return '$label debe tener mínimo 3 carácteres';
  }
  return null;
}

String? validarTexto(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  return null;
}

String? validarEdad(String value) {
  if (value.isEmpty) {
    return 'Edad es obligatorio';
  }
  return null;
}
