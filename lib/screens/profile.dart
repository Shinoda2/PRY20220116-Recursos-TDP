import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/services/datos-medico.dart';
import 'package:pry20220116/screens/edit_profile.dart';

import '../widgets/navigation_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _LoginMedicoState createState() => _LoginMedicoState();
}

class _LoginMedicoState extends State<Profile> {
  var email = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final dniController = TextEditingController();
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Medico>(
          future: getMedicUserName(email),
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
                          Text(
                            nombreController.text,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'EMAIL:' + email,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'NOMBRE COMPLETO: ' + nombreController.text,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'EDAD: ' + edadController.text,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'DNI: ' + dniController.text,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'DIRECCIÓN: ' + direccionController.text,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditProfile()));
                              },
                              child: Text('Editar'))
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
