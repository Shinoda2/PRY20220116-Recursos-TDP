import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/medico/side_bar_medico.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/services/datos_medico.dart';
import 'package:pry20220116/screens/medico/perfil_medico.dart';

import '../widgets/medico/bottom_nav_bar_medico.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditMedicProfile createState() => _EditMedicProfile();
}

class _EditMedicProfile extends State<EditProfile> {
  var email = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final dniController = TextEditingController();
    final docController = TextEditingController();
    return Scaffold(
      drawer: MSideBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MPerfilStf()));
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Medico>(
          future: getDataMedico(email),
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
                                      print(docController.text);
                                      editarMedico(
                                          docController.text,
                                          nombreController.text,
                                          edad!,
                                          direccionController.text);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MPerfilStf()));
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
      bottomNavigationBar: MBottomNavBar(),
    );
  }
}
