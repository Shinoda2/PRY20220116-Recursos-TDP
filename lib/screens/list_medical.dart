import 'package:flutter/widgets.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';

import '../widgets/medical_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar_patient.dart';

class ListMedical extends StatefulWidget{
  //ListPatient(Key key): super(key: key);
  @override
  _ListMedical createState() => _ListMedical();
}

class _ListMedical extends State<ListMedical> {
  List<Medical> medicals = Medical.generateMedical();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        title: Text('MEDICOS'),
        centerTitle: true,
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

      body: ListView.builder(
        itemCount: medicals.length,
        itemBuilder: (context,index)=> MedicalCard(medicals[index]),
     ),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}
