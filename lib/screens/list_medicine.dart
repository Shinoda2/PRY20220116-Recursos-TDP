import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/models/medicine.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';

class ListMedicine extends StatefulWidget {
  const ListMedicine({Key? key}) : super(key: key);

  @override
  _ListMedicine createState() => _ListMedicine();
}

class _ListMedicine extends State<ListMedicine> {
  bool isGrid = true;
  late Future<List<Medicine>> medicines;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    medicines = getMedicines();
  }

  Future<List<Medicine>> getMedicines() async {
    List<Medicine> medicines = [];
    await db.collection("medicamento").get().then(
      (res) {
        debugPrint("Successfully completed");
        res.docs.forEach(
          (element) {
            print(element.data());
          },
        );
        res.docs.forEach(
          (element) {
            medicines.add(
              Medicine.fromFirestore(element, null),
            );
          },
        );
        debugPrint(medicines.toString());
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
    return medicines;
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    // final double itemHeight = (size.height - kToolbarHeight) / 2;
    // final double itemWidth = size.width / 2;

    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
        title: const Text('MEDICAMENTOS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePatient()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Medicine>>(
          future: medicines,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Colors.blueGrey,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // child: Column(
                      //   children: [
                      //     Image.network(
                      //       '${item.imagen}',
                      //       height: 170,
                      //       fit: BoxFit.cover,
                      //     ),
                      //     const SizedBox(height: 15),
                      //     Text(
                      //       item.nombre!,
                      //       // style: TextStyle(
                      //       //   fontWeight: FontWeight.bold,
                      //       //   fontSize: 20,
                      //       // ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ],
                      // ),
                      child: GridTile(
                        header: Container(
                          color: Colors.white,
                          child: Text(
                            item.nombre!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                        child: Image.network(
                          '${item.imagen}',
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                        footer: Container(
                          color: Colors.white,
                          child: Text(
                            "Stock: " + item.stock.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
