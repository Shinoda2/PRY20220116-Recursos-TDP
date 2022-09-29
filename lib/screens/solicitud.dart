import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/home.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';
import 'package:pry20220116/widgets/with_tooltip.dart';
import 'package:pry20220116/widgets/input_with_help.dart';
import 'package:pry20220116/widgets/primary_button.dart';

import '../widgets/nav_bar.dart';
import '../widgets/nav_bar_patient.dart';

class Solicitud extends StatefulWidget {
  const Solicitud({Key? key}) : super(key: key);

  @override
  State<Solicitud> createState() => _Solicitud();
}

class Paciente{
  final String? nombre;
  final int? edad;
  final String? direccion;
  final int? dni;

  const Paciente(
      {this.nombre,
    this.edad,
        this.direccion,
        this.dni,
});

  factory Paciente.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Paciente(
  nombre: data?['nombre'],
  edad: data?['edad'],
      direccion: data?['direccion'],
      dni: data?['dni_paciente'],
  );
  }
}

final db = FirebaseFirestore.instance;

class _Solicitud extends State<Solicitud> {
  final direccionController = TextEditingController();
  String _selectedMenu = '';
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0',
      style: optionStyle,
    ),

    ChatBot(),
    Solicitud()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  CollectionReference solicitud = FirebaseFirestore.instance.collection("solicitud");

  Future<void> crearSolicitud(String direccion, int dni, int edad, String nombre, String sintomas){
    return solicitud
        .add({
      'direccion': direccion,
      'dni_paciente': dni,
      'edad': edad,
      'nombre': nombre,
      'sintomas': sintomas,
    })
        .then((value) => print('Solicitud generada correctamente.'))
        .catchError((error) => print('Solicitud no fue generada'));
  }

  Future<Paciente> getUserName(String email) async {
    var username = '';
    int edad = 0;
    var direccion = '';
    int dni = 0;
    try {
      await db.collection("paciente").where("email", isEqualTo: email)
          .get()
          .then((event) {
        for (var doc in event.docs) {
          username = doc.data()["nombre"];
          edad = doc.data()["edad"];
          direccion = doc.data()["direccion"];
          dni = doc.data()["dni_paciente"];
        }
      });
    } catch (e) {
      print(e);
    }
    var paciente = Paciente(nombre: username, edad: edad, direccion: direccion, dni: dni);
    return paciente;
  }

  var email = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final sintomasController = TextEditingController();
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
      body: SingleChildScrollView(
        child: FutureBuilder<Paciente>(
          future: getUserName(email),
          builder: (context, snapshot){
            switch(snapshot.connectionState) {
              case(ConnectionState.waiting):
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case(ConnectionState.done):nombreController.text = snapshot.data!.nombre!;
              edadController.text = snapshot.data!.edad!.toString();
              direccionController.text = snapshot.data!.direccion!;
              return  Column(
                children: [
                  WithTooltip(child: Text('SOLICITUD', style: Theme.of(context).textTheme.headline1,), tooltipMessage: 'Ayuda'),
                  const SizedBox(height: 15,),
                  Form(
                    child: Column(
                      children: [
                        InputWithHelp(placeholder: 'NOMBRE COMPLETO', tooltipMessage: 'Ayuda', controlador: nombreController,),
                        InputWithHelp(placeholder: 'EDAD', tooltipMessage: 'Ayuda', controlador: edadController,),
                        InputWithHelp(placeholder: 'DIRECCION', tooltipMessage: 'Ayuda', controlador: direccionController,),
                        InputWithHelp(placeholder: 'SINTOMAS', tooltipMessage: 'Ayuda', multiline: true, controlador: sintomasController,),
                        const SizedBox(height: 15,),
                        PrimaryButton(text: 'ENVIAR', onPressed: () {
                          crearSolicitud(direccionController.text, snapshot.data!.dni!, snapshot.data!.edad!, nombreController.text, sintomasController.text);
                        })
                      ],
                    ),
                  )
                ],
              );
              default: return Text('Algo salió mal.');
            }
          },
        ),
    ),bottomNavigationBar: NavigationBarPatient());
  }

}

