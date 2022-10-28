// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utilities/constraints.dart';

class PListaMedicinas extends StatelessWidget {
  const PListaMedicinas({Key? key}) : super(key: key);

  static String id = '/listaMedicinas';

  @override
  Widget build(BuildContext context) {
    return const PListaMedicinasWidget();
  }
}

class PListaMedicinasWidget extends StatefulWidget {
  const PListaMedicinasWidget({super.key});

  @override
  _PListaMedicinasWidget createState() => _PListaMedicinasWidget();
}

class _PListaMedicinasWidget extends State<PListaMedicinasWidget> {
  String _search = '';
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Medicinas", style: kTituloCabezera),
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
              stream: FirebaseFirestore.instance
                  .collection('medicamento')
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
                          if (_search.isEmpty) {
                            return medicineCardItem(data);
                          }
                          if (data['nombre']
                              .toString()
                              .toLowerCase()
                              .contains(_search.toLowerCase())) {
                            return medicineCardItem(data);
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

  Widget medicineCardItem(Map<String, dynamic> data) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        data['nombre'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: kTitulo1,
      ),
      subtitle: Text(
        'Stock: ${data["stock"]}',
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
