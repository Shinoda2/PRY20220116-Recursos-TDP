// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/admin/crear_medico.dart';
import 'package:pry20220116/screens/admin/lista_medicamentos.dart';
import 'package:pry20220116/screens/admin/lista_medico.dart';
import 'package:pry20220116/screens/admin/lista_paciente.dart';
import 'package:pry20220116/screens/shared/inicio.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  static String id = '/adminHome';

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Panel de Administrador"),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Logueado con ${currentUser.email!}"),
                  btnCrearMedico(),
                  btnListaMedicos(),
                  btnListaPacientes(),
                  btnListaMedicamentos(),
                  btnCerrarSesion(),
                ],
              ),
            ),
            Flexible(
              child: Image.asset('assets/image/medico.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget btnCrearMedico() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearMedicoPage()),
          );
        },
        child: Text("Crear médico"));
  }

  Widget btnListaMedicos() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaMedicoPage()),
          );
        },
        child: Text("Lista médicos"));
  }

  Widget btnListaMedicamentos() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaMedicamentoPage()),
          );
        },
        child: Text("Lista medicamentos"));
  }

  Widget btnListaPacientes() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaPacientePage()),
          );
        },
        child: Text("Lista pacientes"));
  }

  Widget btnCerrarSesion() {
    return ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, StartPage.id);
        },
        child: Text("Cerrar sesión"));
  }
}
