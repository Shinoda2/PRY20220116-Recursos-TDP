// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/medico/login_medico.dart';
import 'package:pry20220116/widgets/medico/bottom_nav_bar_medico.dart';

class AnalisisMedico extends StatelessWidget {
  const AnalisisMedico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MBottomNavBar();
            } else {
              return MLoginWidget();
            }
          }),
    );
  }
}
