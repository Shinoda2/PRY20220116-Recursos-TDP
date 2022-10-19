import 'package:flutter/material.dart';
import 'package:pry20220116/models/lista_pacientes.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/medico/side_bar_medico.dart';
import 'package:pry20220116/widgets/patient_card.dart';

import '../../widgets/medico/bottom_navBar_medico.dart';

class MListaConversaciones extends StatefulWidget {
  const MListaConversaciones({super.key});

  @override
  _MListaConversacionesState createState() => _MListaConversacionesState();
}

class _MListaConversacionesState extends State<MListaConversaciones> {
  /*List<Patient> patients=[
    Patient('Elizabeth','assets/image/icon.png','16:00','Hola'),
    Patient('Jose Carlos','assets/image/icon.png','17:00','Hola'),
    Patient('Patricio','assets/image/icon.png','13:00','Hola'),
    Patient('Maria','assets/image/icon.png','10:30','Hola'),
    Patient('Miguel','assets/image/icon.png','9:23','Hola'),
  ];*/
  List<Patient> patients = Patient.generatePatient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) => PatientCard(patients[index]),
      ),
    );
  }
}
