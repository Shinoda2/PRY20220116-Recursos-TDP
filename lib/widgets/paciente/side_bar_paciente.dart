import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/paciente/lista_medicos_paciente.dart';
import 'package:pry20220116/screens/paciente/lista_medicinas_paciente.dart';

import '../../main.dart';
import '../../models/paciente.dart';
import '../../screens/paciente/perfil_paciente.dart';
import '../../services/datos_paciente.dart';
import '../../utilities/constraints.dart';

class PSideBar extends StatelessWidget {
  const PSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var correo = FirebaseAuth.instance.currentUser!.email!;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<Paciente>(
            future: getDataPaciente(correo),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const UserAccountsDrawerHeader(
                    accountName: CircularProgressIndicator(color: Colors.white),
                    accountEmail:
                        CircularProgressIndicator(color: Colors.white),
                    currentAccountPicture:
                        CircularProgressIndicator(color: Colors.white),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data!.nombre!,
                        style: const TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        correo,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: Image.asset(
                          'assets/image/icon.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return UserAccountsDrawerHeader(
                      accountName: const Text('Nombre Completo'),
                      accountEmail: const Text('example@gmail.com'),
                      currentAccountPicture: CircleAvatar(
                        child: Image.asset(
                          'assets/image/icon.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                default:
                  return const UserAccountsDrawerHeader(
                    accountName: Text("accountFirstName + accountLastName"),
                    accountEmail: Text("accountEmail"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: colorSecundario,
                    ),
                  );
              }
            },
          ),
          ListTile(
            title: const Text(
              'Perfil',
              style: TextStyle(color: Colors.black54),
            ),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, PPerfil.id);
            },
          ),
          ListTile(
            title: const Text(
              'Médicos',
              style: TextStyle(color: Colors.black54),
            ),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.pushNamed(context, PListaMedicos.id);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_hospital_outlined),
            title: const Text(
              'Medicamentos',
              style: TextStyle(color: Colors.black54),
            ),
            onTap: () {
              Navigator.pushNamed(context, PListaMedicinas.id);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: kLineaDivisora,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushNamed(context, MyHomePage.id);
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
