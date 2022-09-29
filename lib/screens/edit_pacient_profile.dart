import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/models/medico.dart';
import 'package:pry20220116/services/datos-paciente.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';

import '../models/paciente.dart';
import '../widgets/input_with_help.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/with_tooltip.dart';

class EditProfilePaciente extends StatefulWidget{
  const EditProfilePaciente({Key? key}) : super(key: key);

  @override
  _EditPacienteProfile createState() => _EditPacienteProfile();
}

class _EditPacienteProfile extends State<EditProfilePaciente>{
  var email = FirebaseAuth.instance.currentUser!.email!;


  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final edadController = TextEditingController();
    final direccionController = TextEditingController();
    final dniController = TextEditingController();
    final docController = TextEditingController();
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
              docController.text = snapshot.data!.docid!;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    child: Image.asset('assets/image/icon.png', height: 150,),
                  ),
                  Container(
                    child: Column(
                      children: [
                        WithTooltip(child: Text('EDITAR PERFIL', style: Theme.of(context).textTheme.headline1,), tooltipMessage: 'Ayuda'),
                        const SizedBox(height: 15,),
                        Form(
                          child: Column(
                            children: [
                              InputWithHelp(placeholder: 'NOMBRE COMPLETO', tooltipMessage: 'Ayuda', controlador: nombreController,),
                              InputWithHelp(placeholder: 'EDAD', tooltipMessage: 'Ayuda', controlador: edadController,),
                              InputWithHelp(placeholder: 'DIRECCION', tooltipMessage: 'Ayuda', controlador: direccionController,),
                              const SizedBox(height: 15,),
                              ElevatedButton(onPressed: (){
                                var edad = int.tryParse(edadController.text);
                                print(docController.text);
                                editarPaciente(docController.text, nombreController.text, edad!, direccionController.text);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => ProfilePatient()
                                ));
                              }, child: Text('Guardar'))
                            ],
                          ),
                        ),
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
