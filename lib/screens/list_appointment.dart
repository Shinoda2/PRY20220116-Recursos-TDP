import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/paciente/perfil_paciente.dart';
import 'package:pry20220116/widgets/appointment_card.dart';
import 'package:pry20220116/widgets/paciente/side_bar_paciente.dart';
import 'package:pry20220116/widgets/paciente/bottom_navBar_paciente.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      drawer: PSideBar(),
      appBar: AppBar(
        title: Text('MIS CITAS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PPerfilWidget()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'EN CURSO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appointments1.length,
                itemBuilder: (context, index) =>
                    AppointmentCard(appointments1[index]),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PROXIMAS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appointments2.length,
                itemBuilder: (context, index) =>
                    AppointmentCard(appointments2[index]),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PASADAS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: appointments3.length,
                itemBuilder: (context, index) =>
                    AppointmentCard(appointments3[index]),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: PBottomNavBar(),
    );
  }
}
