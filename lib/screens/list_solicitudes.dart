import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:pry20220116/models/paciente.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar_patient.dart';

class ListSolicitudes extends StatefulWidget{
  //ListPatient(Key key): super(key: key);
  @override
  _ListSolicitudes createState() => _ListSolicitudes();
}

class _ListSolicitudes extends State<ListSolicitudes> {
  String name = '';
  bool isGrid=true;

  Future<String> getName() async {
    var nombre = '';
    try{
      await FirebaseFirestore.instance.collection('paciente').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email!)
          .get()
          .then((event){
            for(var doc in event.docs){
              nombre = doc.data()['nombre'];
            }
      });
    }catch(e){
      print(e);
    }
    return nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('MIS SOLICITUDES'),
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
          FutureBuilder(
            future: getName(),
            builder:(context, snapshot) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('solicitud')
                    .where('nombre', isEqualTo: snapshot.data)
                    .snapshots(),
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

                        var fecha = data['fecha_hora'].toDate();
                        fecha = DateFormat.yMMMEd().format(fecha);

                        if (name.isEmpty) {
                          return ListTile(
                            title: Text(
                              data['sintomas'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Fecha: ' +
                                fecha.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        if (data['sintomas']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())) {
                          return ListTile(
                            title: Text(
                              data['sintomas'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Fecha: ' +
                                fecha.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Container();
                      });
                },
              );
            })

        ],
      ),
      bottomNavigationBar: NavigationBarPatient(),);
  }
}