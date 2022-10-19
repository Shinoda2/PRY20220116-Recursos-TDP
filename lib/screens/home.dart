import 'package:flutter/material.dart';
import 'package:pry20220116/screens/paciente/citas_paciente.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/paciente/solicitud_citas_paciente.dart';
import 'package:pry20220116/screens/paciente/citas_paciente.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedMenu = '';

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0',
      style: optionStyle,
    ),
    ChatBot(),
    PSolicitud()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_rounded,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_rounded, size: 30),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
      ),
    );
  }

  AppBar customAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: PopupMenuButton<Menu>(
          icon: const Icon(Icons.menu),
          onSelected: (Menu item) {
            setState(() {
              _selectedMenu = item.name;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Item 1'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemTwo,
                  child: Text('Item 2'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemThree,
                  child: Text('Item 3'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemFour,
                  child: Text('Item 4'),
                ),
              ]),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: CircleAvatar(
            child: Icon(Icons.person_outline_rounded),
          ),
        ),
      ],
    );
  }
}
