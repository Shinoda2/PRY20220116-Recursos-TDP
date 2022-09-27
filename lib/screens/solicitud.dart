import 'package:flutter/material.dart';
import 'package:pry20220116/screens/chatbot.dart';
import 'package:pry20220116/screens/home.dart';
import 'package:pry20220116/widgets/navigation_bar.dart';
import 'package:pry20220116/widgets/with_tooltip.dart';
import 'package:pry20220116/widgets/input_with_help.dart';
import 'package:pry20220116/widgets/primary_button.dart';

class Solicitud extends StatefulWidget {
  const Solicitud({Key? key}) : super(key: key);

  @override
  State<Solicitud> createState() => _Solicitud();
}

class _Solicitud extends State<Solicitud> {
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
    Solicitud()
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
      body: SingleChildScrollView(
      child: Column(
        children: [
          WithTooltip(child: Text('SOLICITUD', style: Theme.of(context).textTheme.headline1,), tooltipMessage: 'Ayuda'),
          const SizedBox(height: 15,),
          Form(
            child: Column(
              children: [
                InputWithHelp(placeholder: 'NOMBRE COMPLETO', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'EDAD', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'DIRECCION', tooltipMessage: 'Ayuda'),
                InputWithHelp(placeholder: 'SINTOMAS', tooltipMessage: 'Ayuda', multiline: true,),
                const SizedBox(height: 15,),
                PrimaryButton(text: 'SIGUIENTE', onPressed: () {})
              ],
            ),
          )
        ],
      ),
    ),bottomNavigationBar: NavigationBarB());
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

