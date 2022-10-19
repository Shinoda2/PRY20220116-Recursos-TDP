// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pry20220116/screens/shared/chat_page.dart';
import 'package:table_calendar/table_calendar.dart';

class PacienteCalendario extends StatefulWidget {
  const PacienteCalendario({super.key});

  @override
  State<PacienteCalendario> createState() => _PacienteCalendarioState();
}

class _PacienteCalendarioState extends State<PacienteCalendario> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCalendario(),
        MisCitas(),
      ],
    );
  }
}

class MyCalendario extends StatefulWidget {
  const MyCalendario({super.key});

  @override
  State<MyCalendario> createState() => _MyCalendarioState();
}

class _MyCalendarioState extends State<MyCalendario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        headerPadding: EdgeInsets.zero,
        formatButtonVisible: false,
        titleCentered: true,
      ),
      rowHeight: 40.0,
      focusedDay: _focusedDay,
      firstDay: DateTime(1920),
      lastDay: DateTime(2050),
      calendarFormat: _calendarFormat,
      onFormatChanged: (CalendarFormat _format) {
        setState(() {
          _calendarFormat = _format;
        });
      },
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekVisible: true,
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          _selectedDay = selectDay;
          _focusedDay = focusDay;
        });
        print(_focusedDay);
      },
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          color: Color.fromRGBO(72, 189, 255, 0.5),
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(fontSize: 10.0, color: Colors.white),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(fontSize: 10.0, color: Colors.white),
        defaultTextStyle: TextStyle(fontSize: 10.0),
        holidayTextStyle: TextStyle(fontSize: 10.0),
        disabledTextStyle: TextStyle(fontSize: 10.0),
        weekendTextStyle: TextStyle(fontSize: 10.0),
        outsideTextStyle: TextStyle(fontSize: 10.0, color: Color(0xFFAEAEAE)),
      ),
      selectedDayPredicate: (DateTime date) {
        return isSameDay(_selectedDay, date);
      },
    );
  }
}

class MisCitas extends StatefulWidget {
  const MisCitas({super.key});

  @override
  State<MisCitas> createState() => _MisCitasState();
}

class _MisCitasState extends State<MisCitas> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("cita")
          .where("codigo_paciente", isEqualTo: currentUser.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("No se hay citas registradas"),
          );
        }
        return _ListaCita(snapshot: snapshot);
      },
    );
  }
}

class _ListaCita extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const _ListaCita({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.only(),
        children: snapshot.data!.docs.map((document) {
          return _CitaItem(document: document);
        }).toList());
  }
}

class _CitaItem extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> document;
  const _CitaItem({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(document.data());
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatView(
            currentUserId: document["codigo_paciente"],
            anotherUserName: document["nombre_medico"],
            anotherUserId: document["codigo_medico"],
            appointmentId: document["citaId"],
            isFinished: document['isFinished'],
          ),
        ),
      ),
      title: Text(
        //! Nombre de doctor
        "Doctor : ${document["nombre_medico"]}",
      ),
      subtitle: Text(
        "Diagnóstico: ${document["diagnostico"]}",
      ),
      trailing: Text("Ir al chat"),
    );
  }
}
