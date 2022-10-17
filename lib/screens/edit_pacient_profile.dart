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

import '../models/patient.dart';
import '../widgets/input_with_help.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/with_tooltip.dart';

class EditProfilePaciente extends StatefulWidget{
  const EditProfilePaciente({Key? key, required this.docid, required this.nombre, required this.direccion, required this.edad}) : super(key: key);

  final String nombre;
  final int edad;
  final String direccion;
  final String docid;

  @override
  _EditPacienteProfile createState() => _EditPacienteProfile();
}

class _EditPacienteProfile extends State<EditProfilePaciente>{
  var email = FirebaseAuth.instance.currentUser!.email!;
  final nombreController = TextEditingController();
  final edadController = TextEditingController();
  final direccionController = TextEditingController();
  final dniController = TextEditingController();
  final docController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    nombreController.text = widget.nombre;
    edadController.text = widget.edad.toString();
    direccionController.text = widget.direccion;
    docController.text = widget.docid;

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
        child:

    Column(
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
                    PrimaryButton(text: "GUARDAR", onPressed: (){
                      var edad = int.tryParse(edadController.text);
                      print(docController.text);
                      editarPaciente(docController.text, nombreController.text, edad!, direccionController.text);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePatient()
                      ));
                    })
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}
