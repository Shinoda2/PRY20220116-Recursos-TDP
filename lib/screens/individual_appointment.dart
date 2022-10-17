import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/appointment.dart';
import 'package:pry20220116/models/especialidad.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/screens/individual_medical_chat.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';

import '../models/cita.dart';
import '../widgets/navigation_bar_patient.dart';

class IndividualAppointment extends StatefulWidget {
  const IndividualAppointment(
      {Key? key, required this.medical, required this.cita})
      : super(key: key);
  final Medical medical;
  final Cita cita;
  @override
  _IndividualAppointment createState() => _IndividualAppointment();
}

class _IndividualAppointment extends State<IndividualAppointment> {
  //get medical => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
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
                        'Medico: ' + widget.medical.nombre!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.medical.especialidad!.nombre!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Diagnostico: ' + widget.cita.diagnostico!,
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
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}