import 'package:flutter/material.dart';
import 'package:pry20220116/screens/calendar.dart';
import 'package:pry20220116/screens/calendar_patient.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/chatbot_patient.dart';
import 'package:pry20220116/screens/list_medical.dart';
import 'package:pry20220116/screens/list_patient.dart';
import 'package:pry20220116/screens/solicitud.dart';

class NavigationBarPatient extends StatefulWidget{
  const NavigationBarPatient({Key? key}) : super(key: key);

  @override
  _NavigationBarPatient createState()=> _NavigationBarPatient();

}

class _NavigationBarPatient extends State<NavigationBarPatient>{
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
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>CalendarPatient()));
          }
          else if (index==1){
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>ChatBotPatient()));
          }
          else if (index==2){
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>Solicitud()));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
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
              label: 'Solicitud'
          ),
        ]
    );
  }
}