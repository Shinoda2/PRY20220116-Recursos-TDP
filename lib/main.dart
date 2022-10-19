import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:pry20220116/screens/inicio.dart';
import 'package:pry20220116/screens/paciente/lista_medicinas_paciente.dart';
import 'package:pry20220116/screens/paciente/lista_medicos_paciente.dart';
import 'package:pry20220116/screens/paciente/login_paciente.dart';
import 'package:pry20220116/screens/paciente/perfil_paciente.dart';
import 'package:pry20220116/utilities/constraints.dart';
import 'package:pry20220116/widgets/paciente/bottom_navBar_paciente.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDAkVaZFWRkA2rWnH3fKMIOEH2wpc9CSG0",
        appId: "1:340493700277:android:37e3aea13ec36f5ba342fc",
        messagingSenderId: "340493700277",
        projectId: "wisha-database"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pixelRatio = window.devicePixelRatio;
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;

    return MaterialApp(
      title: 'Wisha',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: logicalWidth / 14, // 360 / 18
            fontWeight: FontWeight.w600, // Semi-bold
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: logicalWidth / 18, // 360 / 18
            fontWeight: FontWeight.w500, // Medium
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: logicalWidth / 20, // 360 / 16
            fontWeight: FontWeight.w500, // Medium
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: logicalWidth / 20, // 360 / 16
            fontWeight: FontWeight.w600, // Semi-bold
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontSize: logicalWidth / 22, // 360 / 16
            fontWeight: FontWeight.w400, // Regular
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: logicalWidth / 24, // 360 / 14
            fontWeight: FontWeight.w400, // Regular
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: logicalWidth / 26, // 360 / 12
            fontWeight: FontWeight.w400, // Regular
            color: Colors.black,
          ),
          caption: TextStyle(
            fontSize: logicalWidth / 26, // 360 / 12
            fontWeight: FontWeight.w400, // Regular
            color: Colors.black54,
          ),
          overline: TextStyle(
            fontSize: logicalWidth / 26, // 360 / 10
            fontWeight: FontWeight.w500, // Medium
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: colorPrincipal,
          secondary: colorSecundario,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => const MyHomePage(),
        PLogin.id: (context) => const PLogin(),
        PPerfil.id: (context) => const PPerfil(),
        PListaMedicos.id: (context) => const PListaMedicos(),
        PListaMedicinas.id: (context) => const PListaMedicinas(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static String id = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PBottomNavBar();
            } else {
              return const Inicio();
            }
            // if (snapshot.hasData && snapshot.data!.emailVerified == false) {
            //  //identificador si es medico o paciente
            //   return MBottomNavBar();
            // } else if (snapshot.hasData &&
            //     snapshot.data!.emailVerified == true) {
            //   return const PBottomNavBar();
            // } else {
            //   return const Inicio();
            // }
          },
        ),
      );
}
