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
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/services/datos-paciente.dart';

import '../widgets/nav_bar.dart';
import '../widgets/nav_bar_patient.dart';

class Solicitud extends StatefulWidget {
  const Solicitud({Key? key}) : super(key: key);

  @override
  State<Solicitud> createState() => _Solicitud();
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
                          InputWithHelp(placeholder: 'SINTOMAS', tooltipMessage: 'Ayuda', multiline: true, controlador: sintomasController, inputTextController: sintomasController,),
                          const SizedBox(height: 15,),
                          PrimaryButton(text: 'ENVIAR', onPressed: () {
                            crearSolicitud(direccionController.text, snapshot.data!.dni!, snapshot.data!.edad!, nombreController.text, sintomasController.text, Timestamp.now())
                                .then((value) => _updateObsSuccess(context))
                                .onError((error, stackTrace) => _updateObsSuccess(context));
                            crearcita(sintomasController.text, 1, 1, Timestamp.fromDate(DateTime.now().add(Duration(days:8, hours: 14))));
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

Future<void> _updateObsSuccess(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
        actionsPadding: EdgeInsets.only(bottom: 10),
        title: Text(
          'Solicitud Registrada',
          style: TextStyle(fontSize: 13),
        ),
        content: RichText(
          text: TextSpan(
            text: 'Su solicitud se registró correctamente.',
            style: DefaultTextStyle.of(context).style,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("ACEPTAR", style: TextStyle(fontSize: 10)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Solicitud()));
            },
          )
        ],
      );
    },
  );
}