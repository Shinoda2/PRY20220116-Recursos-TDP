import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/nav_bar.dart';

class Profile extends StatefulWidget{
  const Profile({Key? key}) : super(key: key);

  @override
  _LoginMedicoState createState() => _LoginMedicoState();
}

class _LoginMedicoState extends State<Profile>{
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
                  builder: (BuildContext context) => Profile()));
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
                  Text('José Juarez',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10),
                  Text('DERMATÓLOGO',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 20),
                  Text('NOMBRE COMPLETO: JOSÉ LUIS JUAREZ MATOS',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      ),),
                  SizedBox(height: 10),
                  Text('DNI: 70130621',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      ),),
                  SizedBox(height: 10),
                  Text('ESPECIALIDAD: DERMATOLOGÍA',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                     ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
