// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/services/datos_medico.dart';

class ListaMedicamentoPage extends StatefulWidget {
  const ListaMedicamentoPage({super.key});

  @override
  State<ListaMedicamentoPage> createState() => _ListaMedicamentoPageState();
}

class _ListaMedicamentoPageState extends State<ListaMedicamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de médicos"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("medicamento").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var medicamento =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return medicineItem(medicamento);
                }),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget medicineItem(Map<String, dynamic> medicamento) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(medicamento["urlImage"]),
          ),
          title: Text(
            medicamento["nombre"],
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Stock: ${medicamento["stock"]}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
