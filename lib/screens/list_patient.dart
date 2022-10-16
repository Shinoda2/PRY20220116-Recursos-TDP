import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/patient.dart';
import 'package:pry20220116/models/patients.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/widgets/patient_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cita.dart';
import '../models/medical.dart';
import '../widgets/navigation_bar.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({Key? key, this.email}) : super(key: key);
  final String? email;
  @override
  _ListPatient createState() => _ListPatient();
}

class _ListPatient extends State<ListPatient> {
  //List<Patient> patients = Patient.generatePatient();
  String id = "1";
  late SharedPreferences prefs;
  final db = FirebaseFirestore.instance;
  late Medical medical;
  List<Patient> patients = [];
  List<Cita> citas = [];
  late Future<bool> isDone;
  late String? lastMessage;
  late DateTime? lastMessageDate;

  @override
  void initState() {
    super.initState();
    isDone = getAll();
    getLastMessage("medico_paciente");
  }

  getLastMessage(String chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .limit(1)
        .get()
        .then((value) => value.docs.forEach((element) {
              lastMessage = element["message"];
              lastMessageDate = element["time"].toDate();
            }));
  }

  Future<bool> getAll() async {
    await db
        .collection("medico")
        .where("email", isEqualTo: widget.email)
        .get()
        .then(
      (res) {
        medical = Medical.fromFirestore(res.docs[0], null);
        id = res.docs[0].id;
      },
      onError: (e) => print("Error completing: $e"),
    );
    await db
        .collection('cita')
        .where("codigo_medico", isEqualTo: int.parse(id))
        .get()
        .then((QuerySnapshot res) {
      res.docs.forEach((doc) {
        citas.add(
          Cita.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>, null),
        );
        print('Document data cita: ${doc.data()}');
      });
    });
    List<String> codigos = [];
    citas.forEach(
      (element) {
        codigos.add(element.codigo_paciente.toString());
      },
    );
    debugPrint(codigos.toString());
    //codigos = codigos.toSet().toList();
    //debugPrint(codigos.toString());
    await db
        .collection('paciente')
        .where(FieldPath.documentId, whereIn: codigos)
        .get()
        .then((QuerySnapshot res) {
      res.docs.forEach((doc) {
        patients.add(
          Patient.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>, null),
        );
        print('Document data paciente: ${doc.data()}');
      });
    });
    return true;
  }

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
      body: FutureBuilder<bool>(
          future: isDone,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                lastMessage != null &&
                lastMessageDate != null) {
              return ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) => PatientCard(patients[index],
                    "medico_paciente", lastMessage, lastMessageDate),
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: NavigationBarB(),
    );
  }
}
