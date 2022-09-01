import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/medicine.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/nav_bar.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';

class ListMedicine extends StatefulWidget{
  const ListMedicine({Key? key}) : super(key: key);

  @override
  _ListMedicine createState() => _ListMedicine();
}

class _ListMedicine extends State<ListMedicine>{
  bool isGrid=true;
  List<Medicine> medicines = Medicine.generateMedicine();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        title: Text('MEDICAMENTOS'),
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
      body: Container(
        color: Colors.blueGrey,
        child: GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
            ),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final item= medicines[index];
              return GridTile(
                child: Image.asset(
                  '${item.icon}',
                  height: 20,
                  //fit: BoxFit.cover,
              ),
                footer: Text(item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
        ),
      ),
    );
  }



}