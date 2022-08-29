import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/list_patient.dart';
import 'package:pry20220116/screens/option.dart';

class NavBar extends StatelessWidget{
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
            title: Text('Pacientes',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListPatient()));
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Historial',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            onTap: ()=>null,
          ),
          Divider(),
          SizedBox(height: 270,),
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