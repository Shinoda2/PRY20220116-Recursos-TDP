import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:pry20220116/models/medicine.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';

class ListMedicine extends StatefulWidget{
  const ListMedicine({Key? key}) : super(key: key);

  @override
  _ListMedicine createState() => _ListMedicine();
}

class _ListMedicine extends State<ListMedicine>{
  String name = '';
  bool isGrid=true;
  List<Medicine> medicines = Medicine.generateMedicine();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarPatient(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('MEDICAMENTOS'),
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
              stream: FirebaseFirestore.instance.collection('medicamento').snapshots(),
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
                          subtitle: Text('Stock: '+
                            data['stock'].toString(),
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
                          subtitle: Text('Stock: '+
                            data['stock'].toString(),
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