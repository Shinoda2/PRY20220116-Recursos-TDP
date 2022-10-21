import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utilities/constraints.dart';

class DetalleCita extends StatefulWidget {
  final String _nombrePaciente;
  final String _sintoma;
  final String _nombreMedico;
  final Timestamp _fecha;
  final bool _finalizado;

  const DetalleCita({
    super.key,
    required String nombrePaciente,
    required String sintoma,
    required String nombreMedico,
    required Timestamp fecha,
    required bool finalizado,
  })  : _nombrePaciente = nombrePaciente,
        _nombreMedico = nombreMedico,
        _sintoma = sintoma,
        _fecha = fecha,
        _finalizado = finalizado;

  @override
  _DetalleCitaState createState() => _DetalleCitaState();
}

class _DetalleCitaState extends State<DetalleCita> {
  //get medical => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text('DETALLES DE CITA', style: kTitulo1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Paciente: ${widget._nombrePaciente}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Médico: ${widget._nombreMedico}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    DateFormat('dd/MM/y hh:mm a').format(
                      widget._fecha.toDate(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Síntomas: ${widget._sintoma}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: widget._finalizado
                      ? const Text(
                          'Estado: Finalizado',
                        )
                      : const Text(
                          'Estado: Pendiente',
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
