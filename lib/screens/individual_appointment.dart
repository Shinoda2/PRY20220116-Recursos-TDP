import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/models/lista_medicos.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/paciente/perfil_paciente.dart';
import 'package:pry20220116/widgets/paciente/side_bar_paciente.dart';

import '../widgets/paciente/bottom_navBar_paciente.dart';

class IndividualAppointment extends StatefulWidget {
  const IndividualAppointment({Key? key, required this.appointment})
      : super(key: key);
  final Appointment appointment;
  @override
  _IndividualAppointment createState() => _IndividualAppointment();
}

class _IndividualAppointment extends State<IndividualAppointment> {
  //get medical => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PSideBar(),
      appBar: AppBar(
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "CITA",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: [
                  Text(
                    'Medico: ' + widget.appointment.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.appointment.especialidad,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Diagnostico: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Enter a message here',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualAppointment(appointment: appoin)));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.indigoAccent),
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size.fromWidth(150)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      "VER CHAT",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: PBottomNavBar(),
    );
  }
}
