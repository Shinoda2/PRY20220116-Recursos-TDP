import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/list_medical.dart';
import 'package:pry20220116/screens/login.dart';
import 'package:pry20220116/utils/constants.dart';

class Analisis extends StatelessWidget {
  const Analisis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Constants.name = "paciente";
              return ListMedical();
            } else {
              return const Login();
            }
          }),
    );
  }
}