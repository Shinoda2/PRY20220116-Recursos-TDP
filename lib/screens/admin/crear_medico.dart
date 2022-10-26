// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pry20220116/screens/admin/admin_home.dart';
import 'package:pry20220116/services/datos_medico.dart';

class CrearMedicoPage extends StatefulWidget {
  const CrearMedicoPage({Key? key}) : super(key: key);

  static String id = '/registrarMedico';

  @override
  State<CrearMedicoPage> createState() => _CrearMedicoPageState();
}

class _CrearMedicoPageState extends State<CrearMedicoPage> {
  final _keyForm = GlobalKey<FormState>();
  late bool _passwordVisible;
  final direccionController = TextEditingController();
  final dniController = TextEditingController();
  final edadController = TextEditingController();
  final emailController = TextEditingController();
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final aniosTrabajadosController = TextEditingController();
  final contraseniaController = TextEditingController();
  var selectedSpecialty;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    direccionController.dispose();
    dniController.dispose();
    edadController.dispose();
    emailController.dispose();
    nombreController.dispose();
    telefonoController.dispose();
    aniosTrabajadosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear médico"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                //!Direccion
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: direccionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Dirección",
                    ),
                    validator: ((value) {
                      return validateText("Dirección", value!);
                    }),
                  ),
                ),
                //!DNI
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: dniController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "DNI",
                    ),
                    validator: ((value) {
                      return validateNumber("DNI", 8, value!);
                    }),
                  ),
                ),
                //!Edad
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: edadController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Edad",
                    ),
                    validator: ((value) {
                      return validateNumber("Edad", 0, value!);
                    }),
                  ),
                ),
                //!Email
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: ((value) {
                      return validateText("Email", value!);
                    }),
                  ),
                ),
                //!Especialidad
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("especialidad")
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData) {
                        Text("Loading");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        case ConnectionState.active:
                          List<DropdownMenuItem> specialtyListItems = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            specialtyListItems.add(DropdownMenuItem(
                              child: Text(snap.id),
                              value: snap.id,
                            ));
                          }
                          return DropdownButtonFormField<dynamic>(
                            validator: (value) => value == null
                                ? 'Es necesario seleccionar una especialidad'
                                : null,
                            items: specialtyListItems,
                            value: selectedSpecialty,
                            isExpanded: false,
                            hint: Text("Seleccione especialidad"),
                            onChanged: ((currentSpeciality) {
                              setState(() {
                                selectedSpecialty = currentSpeciality;
                              });
                            }),
                          );
                        default:
                          return Text("Error de carga");
                      }
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
                //!numeroCelular
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
                //!aniosTrabajados
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: aniosTrabajadosController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Años de experiencia",
                    ),
                    validator: ((value) {
                      return validateNumber("Años de experiencia", 0, value!);
                    }),
                  ),
                ),
                //!contraseña
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: contraseniaController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Contraseña",
                    ),
                    validator: ((value) {
                      return validateText("Contraseña", value!);
                    }),
                  ),
                ),
                //!btnEnviar
                ElevatedButton(
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        crearMedico(
                            direccionController.text,
                            dniController.text,
                            edadController.text,
                            emailController.text,
                            selectedSpecialty,
                            nombreController.text,
                            telefonoController.text,
                            aniosTrabajadosController.text,
                            contraseniaController.text);
                      }
                      Navigator.pushNamed(context, AdminHome.id);
                    },
                    child: Text("Crear")),
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
