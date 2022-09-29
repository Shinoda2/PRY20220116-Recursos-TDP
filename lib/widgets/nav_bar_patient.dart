import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/list_appointment.dart';
import 'package:pry20220116/screens/list_medical.dart';
import 'package:pry20220116/screens/list_medicine.dart';
import 'package:pry20220116/screens/option.dart';

class NavBarPatient extends StatelessWidget{
  const NavBarPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Sebastian Jara'),
            accountEmail: const Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Image.asset('assets/image/icon.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: const Text('Buscar Médicos',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListMedical()));
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: const Text('Mis Citas',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ListAppointment()));
          },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: const Text('Medicamentos',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListMedicine()));
            },
          ),
          Divider(),
          SizedBox(height: 200,),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Cerrar Sesión',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Option()
              ));
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }

}