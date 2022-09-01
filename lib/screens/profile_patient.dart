import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/nav_bar.dart';

import '../widgets/navigation_bar.dart';

class ProfilePatient extends StatefulWidget{
  const ProfilePatient({Key? key}) : super(key: key);

  @override
  _ProfilePatient createState() => _ProfilePatient();
}

class _ProfilePatient extends State<ProfilePatient>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePatient()));
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Image.asset('assets/image/icon.png', height: 150,),
            ),
            Container(
              child: Column(
                children: [
                  Text('Sebastian Jara',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10),
                  Text('Usuario',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 20),
                  Text('NOMBRE COMPLETO: Sebastian Jara Calderon',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10),
                  Text('DNI: 72123691',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarB(),
    );
  }
}