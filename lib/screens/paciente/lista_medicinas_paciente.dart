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
  const PListaMedicinasWidget({Key? key}) : super(key: key);

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
        title: const Text("Medicamentos", style: kTituloCabezera),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 240.0,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: kLineaDivisora,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('medicamento')
                  .snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
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
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                data['nombre'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTitulo2,
                              ),
                              subtitle: Text(
                                'Stock: ' + data['stock'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kHintText,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data['imagen']),
                              ),
                            );
                          }
                          if (data['nombre']
                              .toString()
                              .toLowerCase()
                              .startsWith(_search.toLowerCase())) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                data['nombre'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTitulo2,
                              ),
                              subtitle: Text(
                                'Stock: ' + data['stock'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kHintText,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data['imagen']),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
