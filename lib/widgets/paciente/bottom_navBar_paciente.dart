import 'package:flutter/material.dart';
import 'package:pry20220116/screens/paciente/citas_pa.dart';
import 'package:pry20220116/screens/paciente/citas_paciente.dart';
import 'package:pry20220116/screens/paciente/chatbot_paciente.dart';
import 'package:pry20220116/screens/paciente/solicitud_citas_paciente.dart';
import '../../utilities/constraints.dart';
import 'side_bar_paciente.dart';

class PBottomNavBar extends StatefulWidget {
  const PBottomNavBar({Key? key}) : super(key: key);

  static String id = '/botomNavBar';

  @override
  _PBottomNavBar createState() => _PBottomNavBar();
}

class _PBottomNavBar extends State<PBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [PChatBot(), PacienteCalendario(), PSolicitud()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: colorPrincipal),
      drawer: const PSideBar(),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.smart_toy_outlined, size: 40.0),
            ),
            label: 'CHATBOT',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.calendar_today_rounded, size: 40.0),
            ),
            label: 'CITAS',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.feed_outlined, size: 40.0),
            ),
            label: 'SOLICITUD',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: colorPrincipal,
      ),
    );
  }
}
