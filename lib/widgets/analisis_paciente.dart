import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/paciente/login_paciente.dart';
import 'package:pry20220116/widgets/paciente/bottom_navBar_paciente.dart';

class Analisis extends StatelessWidget {
  const Analisis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const PBottomNavBar();
          } else {
            return const PLogin();
          }
        },
      ),
    );
  }
}
