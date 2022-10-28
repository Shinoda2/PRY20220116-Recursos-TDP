// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/services/datos_medico.dart';
import '../../utilities/constraints.dart';

class MPerfil extends StatelessWidget {
  const MPerfil({Key? key}) : super(key: key);

  static String id = '/perfilMedico';

  @override
  Widget build(BuildContext context) {
    return const MPerfilStf();
  }
}

class MPerfilStf extends StatefulWidget {
  const MPerfilStf({Key? key}) : super(key: key);

  @override
  _MPerfilState createState() => _MPerfilState();
}

class _MPerfilState extends State<MPerfilStf> {
  final _keyForm = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final edadController = TextEditingController();
  final direccionController = TextEditingController();
  final dniController = TextEditingController();
  final correoController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    direccionController.dispose();
    dniController.dispose();
    correoController.dispose();
    super.dispose();
  }

  var correo = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil", style: kTituloCabezera),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Medico>(
          future: getDataMedico(correo),
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
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Algo salió mal..."),
                  );
                }
                nombreController.text = snapshot.data!.nombre!;
                edadController.text = snapshot.data!.edad!.toString();
                direccionController.text = snapshot.data!.direccion!;
                dniController.text = snapshot.data!.dni!.toString();
                correoController.text = correo;
                return SingleChildScrollView(
                  child: Form(
                    key: _keyForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CircleAvatar(
                              radius: 45,
                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data!.urlImage!,
                                ),
                              ),
                            ),
                          ),
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
                            readOnly: false,
                          ),
                          InputTextWidget(
                            controlador: edadController,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            label: 'Edad',
                            inputType: TextInputType.number,
                            validacion: (value) {
                              return validarNumero("Edad", value!);
                            },
                            readOnly: false,
                          ),
                          InputTextWidget(
                            controlador: correoController,
                            formatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z á-ú ]")),
                            ],
                            label: 'Correo',
                            inputType: TextInputType.text,
                            validacion: (value) {
                              return validarTexto("Correo", value!);
                            },
                            readOnly: true,
                          ),
                          InputTextWidget(
                            controlador: dniController,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            label: 'DNI',
                            inputType: TextInputType.number,
                            validacion: (value) {
                              return validarNumero("DNI", value!);
                            },
                            readOnly: false,
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
                            readOnly: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  var edad = int.tryParse(edadController.text);
                                  var dni = int.tryParse(dniController.text);
                                  //print(docController.text);
                                  editarMedico(
                                          currentUserId,
                                          nombreController.text,
                                          edad!,
                                          dni!,
                                          direccionController.text)
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
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return const Text('Algo salió mal.');
            }
          },
        ),
      ),
    );
  }
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
  }) : super(key: key);

  final TextEditingController controlador;
  final TextInputType inputType;
  final List<TextInputFormatter> formatters;
  final String label;
  final FormFieldValidator<String>? validacion;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
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
          labelStyle: kHintText,
        ),
        validator: validacion,
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

String? validarNumero(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  return null;
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
              Navigator.of(context).popUntil(ModalRoute.withName("/"));
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
