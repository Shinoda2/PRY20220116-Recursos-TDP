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
        title: const Text("Médicos", style: kTituloCabezera),
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
              stream:
                  FirebaseFirestore.instance.collection('medico').snapshots(),
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
                                overflow: TextOverflow.ellipsis,
                                style: kTitulo2,
                              ),
                              subtitle: Text(
                                'Especialidad: ' +
                                    data['especialidad_codigo'].toString(),
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
                                'Especialidad: ' +
                                    data['especialidad_codigo'].toString(),
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
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
