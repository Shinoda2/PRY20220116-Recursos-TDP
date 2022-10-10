import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:pry20220116/models/medical.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
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
  String name = '';
  bool isGrid=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('MÉDICOS'),
        actions: [
          IconButton(
              icon: const Icon(Icons.person),
              onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePatient()
                ));
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Buscar...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('medico').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                    as Map<String, dynamic>;

                    if (name.isEmpty) {
                      return ListTile(
                        title: Text(
                          data['nombre'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Especialidad: '+
                            data['especialidad_codigo'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['imagen']),
                        ),
                      );
                    }
                    if (data['nombre']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return ListTile(
                        title: Text(
                          data['nombre'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Especialidad: '+
                            data['especialidad_codigo'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),

                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['imagen']),
                        ),
                      );
                    }
                    return Container();
                  });
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarPatient(),);
  }
}