import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/home.dart';
import 'package:pry20220116/widgets/navigation_bar.dart';
import 'package:pry20220116/widgets/with_tooltip.dart';
import 'package:pry20220116/widgets/input_with_help.dart';
import 'package:pry20220116/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Solicitud extends StatefulWidget {
  const Solicitud({Key? key}) : super(key: key);

  @override
  State<Solicitud> createState() => _Solicitud();
}

class _Solicitud extends State<Solicitud> {
  final nombre = TextEditingController();
  final edad = TextEditingController();
  final direccion = TextEditingController();
  final sintomas = TextEditingController();
  final db = FirebaseFirestore.instance;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    nombre.dispose();
    edad.dispose();
    direccion.dispose();
    sintomas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                WithTooltip(
                    child: Text(
                      'SOLICITUD',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    tooltipMessage: 'Ayuda'),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  child: Column(
                    children: [
                      InputWithHelp(
                          controller: nombre,
                          placeholder: 'NOMBRE COMPLETO',
                          tooltipMessage: 'Ayuda'),
                      InputWithHelp(
                          controller: edad,
                          placeholder: 'EDAD',
                          tooltipMessage: 'Ayuda',
                          keyboardType: TextInputType.number),
                      InputWithHelp(
                          controller: direccion,
                          placeholder: 'DIRECCION',
                          tooltipMessage: 'Ayuda'),
                      InputWithHelp(
                        controller: sintomas,
                        placeholder: 'SINTOMAS',
                        tooltipMessage: 'Ayuda',
                        multiline: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PrimaryButton(
                          text: 'SIGUIENTE',
                          onPressed: () {
                            DateTime now = DateTime.now();
                            final solicitud = <String, dynamic>{
                              "direccion": direccion.text.trim(),
                              "dni_paciente": "53658376",
                              "edad": int.parse(edad.text),
                              "fecha_hora": now,
                              "nombre": nombre.text.trim(),
                              "sintomas": sintomas.text.trim(),
                            };

                            const snackBar = SnackBar(
                              content: Text('Solicitud enviada'),
                            );

                            db
                                .collection("solicitud")
                                .doc()
                                .set(solicitud)
                                .whenComplete(() =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar))
                                .onError((e, _) =>
                                    print("Error writing document: $e"));
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBarB());
  }

  AppBar customAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: PopupMenuButton<Menu>(
          icon: const Icon(Icons.menu),
          onSelected: (Menu item) {
            setState(() {
              _selectedMenu = item.name;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Item 1'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemTwo,
                  child: Text('Item 2'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemThree,
                  child: Text('Item 3'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemFour,
                  child: Text('Item 4'),
                ),
              ]),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: CircleAvatar(
            child: Icon(Icons.person_outline_rounded),
          ),
        ),
      ],
    );
  }
}
