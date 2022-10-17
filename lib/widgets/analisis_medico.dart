import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/list_patient.dart';
import 'package:pry20220116/screens/login_medico.dart';
import 'package:pry20220116/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalisisMedico extends StatelessWidget {
  AnalisisMedico({Key? key}) : super(key: key);

  void setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //setEmail(snapshot.data!.email!);
              Constants.name = "medico";
              return ListPatient(email: snapshot.data!.email!);
            } else {
              return const LoginMedico();
            }
          }),
    );
  }
}