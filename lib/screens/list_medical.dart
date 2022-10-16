import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/especialidad.dart';

import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';

import '../widgets/medical_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar_patient.dart';

class ListMedical extends StatefulWidget {
  //ListPatient(Key key): super(key: key);

  @override
  _ListMedical createState() => _ListMedical();
}

class _ListMedical extends State<ListMedical> {
  List<Medical> medicals = [];
  List<Especialidad> especialidades = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    //ga();
  }

  Future<String> getMedicals() async {
    await db.collection('medico').get().then((QuerySnapshot res) {
      res.docs.forEach((doc) {
        medicals.add(
          Medical.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>, null),
        );
        print('Document data doctor: ${doc.data()}');
        print(doc["especialidad_codigo"].toString());
      });
    });
    return "Success!";
  }

  Future<String> getEspecialidades() async {
    await db.collection('especialidad').get().then((QuerySnapshot res) {
      res.docs.forEach((doc) {
        especialidades.add(
          Especialidad.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>, null),
        );
        print('Document data especialidad: ${doc.data()}');
      });
    });
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        title: Text('MEDICOS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePatient()));
            },
          ),
        ],
      ),
      body: FutureBuilder<Object>(
          future: Future.wait([getEspecialidades(), getMedicals()]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: medicals.length,
                itemBuilder: (context, index) {
                  return MedicalCard(
                    medical: medicals[index],
                    especialidad:
                        especialidades[medicals[index].especialidadCodigo! - 1],
                    chatRoomId: "medico_paciente",
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}
