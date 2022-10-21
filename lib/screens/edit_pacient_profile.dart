import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pry20220116/screens/paciente/perfil_paciente.dart';
import 'package:pry20220116/services/datos_paciente.dart';
import 'package:pry20220116/widgets/paciente/side_bar_paciente.dart';
import 'package:pry20220116/widgets/paciente/bottom_nav_bar_paciente.dart';

import '../models/paciente.dart';

class EditProfilePaciente extends StatefulWidget {
  const EditProfilePaciente({Key? key}) : super(key: key);

  @override
  _EditPacienteProfile createState() => _EditPacienteProfile();
}

class _EditPacienteProfile extends State<EditProfilePaciente> {
  var email = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final dniController = TextEditingController();
    final docController = TextEditingController();
    return Scaffold(
      drawer: PSideBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PPerfilStf()));
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Paciente>(
          future: getDataPaciente(email),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.waiting):
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case (ConnectionState.done):
                nombreController.text = snapshot.data!.nombre!;
                edadController.text = snapshot.data!.edad!.toString();
                direccionController.text = snapshot.data!.direccion!;
                dniController.text = snapshot.data!.dni!.toString();
                docController.text = snapshot.data!.docid!;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      child: Image.asset(
                        'assets/image/icon.png',
                        height: 150,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      var edad =
                                          int.tryParse(edadController.text);
                                      //print(docController.text);
                                      editarPaciente(
                                          docController.text,
                                          nombreController.text,
                                          edad!,
                                          direccionController.text);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PPerfilStf()));
                                    },
                                    child: Text('Guardar'))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              default:
                return Text('Algo salió mal.');
            }
          },
        ),
      ),
      bottomNavigationBar: PBottomNavBar(),
    );
  }
}
