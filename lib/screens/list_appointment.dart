import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/models/cita.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/appointment_card.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';

import '../widgets/navigation_bar.dart';

class ListAppointment extends StatefulWidget {
  const ListAppointment({Key? key}) : super(key: key);

  @override
  _ListAppointment createState() => _ListAppointment();
}

class _ListAppointment extends State<ListAppointment> {
  List<Appointment> appointments1 = Appointment.enCurso();
  List<Appointment> appointments2 = Appointment.proxima();
  List<Appointment> appointments3 = Appointment.pasadas();

  late Future<List<Cita>> citas;
  List<Cita> enCurso = [];
  List<Cita> proximas = [];
  List<Cita> completadas = [];

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'EN CURSO'),
    Tab(text: 'PRÓXIMAS'),
    Tab(text: 'COMPLETADAS'),
  ];

  Future<List<Cita>> getCitas() async {
    List<Cita> citas = [];
    await FirebaseFirestore.instance
        .collection('cita')
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
    return citas;
  }

  @override
  void initState() {
    super.initState();
    citas = getCitas();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        //backgroundColor: Colors.blueGrey,
        drawer: NavBarPatient(),
        appBar: AppBar(
          title: Text('MIS CITAS'),
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
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: FutureBuilder<List<Cita>>(
            future: citas,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                enCurso = snapshot.data!
                    .where((cita) => DateUtils.dateOnly(cita.fecha!.toDate())
                    .isAtSameMomentAs(DateUtils.dateOnly(DateTime.now())))
                    .toList();
                proximas = snapshot.data!
                    .where((cita) => DateUtils.dateOnly(cita.fecha!.toDate())
                    .isAfter(DateUtils.dateOnly(DateTime.now())))
                    .toList();
                completadas = snapshot.data!
                    .where((cita) => DateUtils.dateOnly(cita.fecha!.toDate())
                    .isBefore(DateUtils.dateOnly(DateTime.now())))
                    .toList();
                return TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: enCurso.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          enCurso[index],
                          hoy: true,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: proximas.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(proximas[index]);
                      },
                    ),
                    ListView.builder(
                      itemCount: completadas.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(completadas[index]);
                      },
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        // Column(
        //   children: [
        //     Column(
        //       children: [
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'EN CURSO',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: appointments1.length,
        //           itemBuilder: (context, index) =>
        //               AppointmentCard(appointments1[index]),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'PROXIMAS',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: appointments2.length,
        //           itemBuilder: (context, index) =>
        //               AppointmentCard(appointments2[index]),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'PASADAS',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: appointments3.length,
        //           itemBuilder: (context, index) =>
        //               AppointmentCard(appointments3[index]),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        bottomNavigationBar: NavigationBarPatient(),
      ),
    );
  }
}