import 'package:flutter/material.dart';
import 'package:pry20220116/models/lista_pacientes.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/widgets/patient_card.dart';

import '../widgets/navigation_bar.dart';

class ListPatient extends StatefulWidget {
  //ListPatient(Key key): super(key: key);
  @override
  _ListPatient createState() => _ListPatient();
}

class _ListPatient extends State<ListPatient> {
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
      drawer: NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Profile()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) => PatientCard(patients[index]),
      ),
      bottomNavigationBar: MBottomNavBar(),
    );
  }
}
