import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  //List<Medical> medicals = Medical.generateMedical();
  late Future<List<Medical>> medicals;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    medicals = getMedicals();
  }

  Future<List<Medical>> getMedicals() async {
    List<Medical> medicals = [];
    await db.collection("medico").get().then(
      (res) {
        debugPrint("Successfully completed");
        res.docs.forEach(
          (element) {
            print(element.data());
          },
        );
        res.docs.forEach(
          (element) {
            medicals.add(
              Medical.fromFirestore(element, null),
            );
          },
        );
        debugPrint(medicals.toString());
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
    return medicals;
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
      body: FutureBuilder<List<Medical>>(
          future: medicals,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    MedicalCard(snapshot.data![index]),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text("Error");
            }
            return const Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}
