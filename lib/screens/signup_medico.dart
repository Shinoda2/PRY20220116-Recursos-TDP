import 'package:flutter/material.dart';

class SignUpMedico extends StatefulWidget{
  const SignUpMedico({Key? key}) : super(key: key);

  @override
  _SignUpMedico createState() => _SignUpMedico();
}

class _SignUpMedico extends State<SignUpMedico>{

  final _formKey = GlobalKey<FormState>();

  final nameEditingController = new TextEditingController();

  final directionEditingController = new TextEditingController();

  final dniEditingController = new TextEditingController();

  final edadEditingController = new TextEditingController();

  final codigodistritoEditingController = new TextEditingController();

  final codigoespecialidadEditingController = new TextEditingController();

  final telefonoEditingController = new TextEditingController();

  final tiempotrabajandoEditingController = new TextEditingController();

  final passwordEditingController = new TextEditingController();

  final confirmpasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value){
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText:  true,
        onSaved: (value){
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
