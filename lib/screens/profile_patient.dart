import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/services/datos-paciente.dart';

import '../widgets/navigation_bar.dart';

class ProfilePatient extends StatefulWidget{
  const ProfilePatient({Key? key}) : super(key: key);

  @override
  _ProfilePatient createState() => _ProfilePatient();
}

class _ProfilePatient extends State<ProfilePatient>{
  var email = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final dniController = TextEditingController();
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
        child: FutureBuilder<Paciente>(
          future: getUserName(email),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case(ConnectionState.waiting):
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height/1.3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case(ConnectionState.done):nombreController.text = snapshot.data!.nombre!;
              edadController.text = snapshot.data!.edad!.toString();
              direccionController.text = snapshot.data!.direccion!;
              dniController.text = snapshot.data!.dni!.toString();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    child: Image.asset('assets/image/icon.png', height: 150,),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(nombreController.text,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10),
                        Text('EMAIL:'+email,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 20),
                        Text('NOMBRE COMPLETO: '+nombreController.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10),
                        Text('EDAD: '+edadController.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10),
                        Text('DNI: '+dniController.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10),
                        Text('DIRECCIÓN: '+direccionController.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              );
              default: return Text('Algo salió mal.');
            }
          },
        ),
      ),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}