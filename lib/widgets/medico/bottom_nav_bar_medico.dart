import 'package:flutter/material.dart';
import 'package:pry20220116/screens/medico/citas_medico.dart';
import 'package:pry20220116/screens/medico/lista_pacientes_medico.dart';
import 'package:pry20220116/screens/shared/chatbot_view.dart';
import 'package:pry20220116/widgets/medico/side_bar_medico.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../utilities/constraints.dart';

class MBottomNavBar extends StatefulWidget {
  const MBottomNavBar({super.key});

  static String id = '/bottomNavBarMedico';

  @override
  _MBottomNavBar createState() => _MBottomNavBar();
}

class _MBottomNavBar extends State<MBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const MCitas(),
    const ChatBotView(),
    const MiListaPacientes()
  ];

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

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
      drawer: const MSideBar(),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
              child: Icon(Icons.smart_toy_outlined, size: 40.0),
            ),
            label: 'CHATBOT',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.people, size: 40.0),
            ),
            label: 'PACIENTES',
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
