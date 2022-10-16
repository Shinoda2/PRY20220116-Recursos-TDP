import 'package:flutter/material.dart';
import 'package:pry20220116/screens/calendar.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/list_patient.dart';
import 'package:pry20220116/screens/solicitud.dart';

class NavigationBarB extends StatefulWidget{
  @override
  _NavigationBarB createState()=> _NavigationBarB();
  
}

class _NavigationBarB extends State<NavigationBarB>{
  int index=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i){
          setState(() {
            index=i;
            });
          if (index==0){
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>Calendar()));
          }
          else if (index==1){
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>ChatBot()));
          }
          else if (index==2){
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>ListPatient()));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[900],
        backgroundColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              label: 'Calendario'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'ChatBot'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check_rounded),
              label: 'Lista de Pacientes'
          ),
        ]
    );
  }
}