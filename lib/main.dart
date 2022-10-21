import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/medico/perfil_paciente_medico.dart';
import 'package:pry20220116/screens/shared/inicio.dart';
import 'package:pry20220116/screens/medico/login_medico.dart';
import 'package:pry20220116/screens/medico/perfil_medico.dart';
import 'package:pry20220116/screens/paciente/lista_medicinas_paciente.dart';
import 'package:pry20220116/screens/paciente/lista_medicos_paciente.dart';
import 'package:pry20220116/screens/paciente/login_paciente.dart';
import 'package:pry20220116/screens/paciente/perfil_paciente.dart';
import 'package:pry20220116/utilities/constraints.dart';
import 'package:pry20220116/widgets/medico/bottom_nav_bar_medico.dart';
import 'package:pry20220116/widgets/paciente/bottom_nav_bar_paciente.dart';

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
    //var pixelRatio = window.devicePixelRatio;
    //var logicalScreenSize = window.physicalSize / pixelRatio;
    //var logicalWidth = logicalScreenSize.width;

    return MaterialApp(
      title: 'Wisha',
      theme: ThemeData(
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
        //paciente
        PLogin.id: (context) => const PLogin(),
        PBottomNavBar.id: (context) => const PBottomNavBar(),
        PPerfil.id: (context) => const PPerfil(),
        PListaMedicos.id: (context) => const PListaMedicos(),
        PListaMedicinas.id: (context) => const PListaMedicinas(),
        //medico
        MLogin.id: (context) => const MLogin(),
        MBottomNavBar.id: (context) => const MBottomNavBar(),
        MPerfil.id: (context) => const MPerfil(),
        MPerfilPaciente.id: (context) => const MPerfilPaciente(),
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
              return const MBottomNavBar();
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
