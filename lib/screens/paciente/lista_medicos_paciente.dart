// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utilities/constraints.dart';

class PListaMedicos extends StatelessWidget {
  const PListaMedicos({Key? key}) : super(key: key);

  static String id = '/listaMedicos';

  @override
  Widget build(BuildContext context) {
    return const PListaMedicosWidget();
  }
}

class PListaMedicosWidget extends StatefulWidget {
  const PListaMedicosWidget({super.key});

  @override
  _PListaMedicosWidget createState() => _PListaMedicosWidget();
}

class _PListaMedicosWidget extends State<PListaMedicosWidget> {
  String _search = '';
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Médicos", style: kTituloCabezera),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            //!Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar...',
                        hintStyle: kHintText,
                        labelStyle: kHintText,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _search = val;
                        });
                      },
                    ),
                  ),
                ),
                Material(
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      //navigateResult(context);
                    },
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            //!Linea
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: kLineaDivisora,
            ),
            //!Lista
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('medico').snapshots(),
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
                          if (_search.isEmpty) {
                            return medicCardItem(data);
                          }
                          if (data['nombre']
                              .toString()
                              .toLowerCase()
                              .contains(_search.toLowerCase())) {
                            return medicCardItem(data);
                          }
                          return Container();
                        });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget medicCardItem(Map<String, dynamic> data) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        data['nombre'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: kTitulo1,
      ),
      subtitle: Text(
        'Especialidad: ' + data['especialidad'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: kHintText,
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(data['urlImage']),
      ),
    );
  }
}
