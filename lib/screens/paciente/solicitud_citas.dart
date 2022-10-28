// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/services/datos_medico.dart';
import 'package:pry20220116/services/datos_paciente.dart';
import 'package:pry20220116/utilities/constraints.dart';
import 'package:pry20220116/widgets/paciente/bottom_nav_bar_paciente.dart';

class SolicitudViewPage extends StatefulWidget {
  const SolicitudViewPage({Key? key}) : super(key: key);

  static String id = '/solicitudPaciente';

  @override
  State<SolicitudViewPage> createState() => _SolicitudViewPageState();
}

class _SolicitudViewPageState extends State<SolicitudViewPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final _keyFormEspecialidad = GlobalKey<FormState>();
  final _keyFormMedico = GlobalKey<FormState>();
  final _keyFormSintoma = GlobalKey<FormState>();
  final sintomaController = TextEditingController();
  var selectedSpecialty, selectedMedic;
  DateTime dateTime = DateTime.now().add(Duration(days: 1));

  final patientService = PatientService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('SOLICITUD DE CITAS', style: kTitulo1),
                SizedBox(height: 20),
                dtFechaHora(context),
                SizedBox(height: 20),
                ddbtnEspecialidad(),
                SizedBox(height: 20),
                ddbtnMedico(),
                SizedBox(height: 20),
                tfSintoma(),
                SizedBox(height: 20),
                btnEnviar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dtFechaHora(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () async {
            DateTime? date = await pickDate(context, dateTime);
            if (date == null) return;

            TimeOfDay? time = await pickTime(context, dateTime);
            if (time == null) return;

            final dt = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);

            setState(() => dateTime = dt);
          },
          child: Text(
            "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${hours}:${minutes}",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }

  Widget ddbtnEspecialidad() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("especialidad").snapshots(),
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
            return Form(
              key: _keyFormEspecialidad,
              child: DropdownButtonFormField<dynamic>(
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
                    selectedMedic = null;
                  });
                }),
              ),
            );
          default:
            return Text("Error de carga");
        }
      }),
    );
  }

  Widget ddbtnMedico() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("medico")
          .where('especialidad', isEqualTo: selectedSpecialty)
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          Text("Loading");
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            List<DropdownMenuItem> medicListItems = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              DocumentSnapshot snap = snapshot.data!.docs[i];
              medicListItems.add(DropdownMenuItem(
                child: Text(snap["nombre"]),
                value: snap.id,
              ));
            }
            return Form(
              key: _keyFormMedico,
              child: DropdownButtonFormField<dynamic>(
                items: medicListItems,
                value: selectedMedic,
                isExpanded: false,
                validator: (value) =>
                    value == null ? 'Es necesario seleccionar un médico' : null,
                hint: Text("Seleccione médico"),
                onChanged: ((currentMedic) {
                  setState(() {
                    selectedMedic = currentMedic;
                  });
                }),
              ),
            );
          default:
            return Text("Error de carga");
        }
      }),
    );
  }

  Widget tfSintoma() {
    return Form(
      key: _keyFormSintoma,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        autocorrect: true,
        style: const TextStyle(fontSize: 12.0),
        readOnly: false,
        controller: sintomaController,
        keyboardType: TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú 0-9 .-/]")),
        ],
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          border: OutlineInputBorder(),
          labelText: 'Síntomas',
          labelStyle: kHintText,
        ),
        validator: (value) {
          return validarTexto("Síntomas", value!);
        },
      ),
    );
  }

  Widget btnEnviar() {
    return FutureBuilder<Paciente>(
      future: patientService.getPatientByUID(currentUser.uid),
      builder: (context, snapPaciente) {
        if (!snapPaciente.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return FutureBuilder<Medico>(
          future: getMedicoByUID(selectedMedic.toString()),
          builder: (context, snapMedico) {
            if (!snapMedico.hasData) {
              return Container();
            }
            return ElevatedButton(
              child: Text("ENVIAR"),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: colorSecundario),
                backgroundColor: colorPrincipal,
                foregroundColor: Colors.white,
                fixedSize: const Size(180.0, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                _keyFormEspecialidad.currentState!.validate();
                _keyFormMedico.currentState!.validate();
                _keyFormSintoma.currentState!.validate();
                if (_keyFormEspecialidad.currentState!.validate() &&
                    _keyFormMedico.currentState!.validate() &&
                    _keyFormSintoma.currentState!.validate()) {
                  patientService.crearCita(
                      snapPaciente.data!.uid!,
                      snapMedico.data!.uid!,
                      Timestamp.fromDate(dateTime),
                      snapMedico.data!.nombre!,
                      snapPaciente.data!.nombre!,
                      sintomaController.text);
                  popUpExito(context);
                } else {
                  popUpFallido(context);
                }
              },
            );
          },
        );
      },
    );
  }
}

String? validarTexto(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  return null;
}

Future<DateTime?> pickDate(BuildContext context, DateTime dateTime) =>
    showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime.now().add(Duration(days: 7)));

Future<TimeOfDay?> pickTime(BuildContext context, DateTime dateTime) =>
    showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PBottomNavBar()));
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
