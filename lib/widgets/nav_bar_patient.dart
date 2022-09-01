import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/list_medical.dart';
import 'package:pry20220116/screens/list_medicine.dart';
import 'package:pry20220116/screens/list_patient.dart';
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
            accountName: Text('José Juarez'),
            accountEmail: Text('example@gmail.com'),
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
            title: Text('Buscar Médicos',
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
            title: Text('Mis Citas',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: ()=>null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Medicamentos',
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
            title: Text('Cerrar Sesión',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Option()
              ));
            },
          ),
        ],
      ),
    );
  }

}