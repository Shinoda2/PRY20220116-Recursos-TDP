import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/constraints.dart';
import '../shared/chat_page.dart';

class MCitas extends StatefulWidget {
  const MCitas({super.key});

  @override
  _MCitasState createState() => _MCitasState();
}

class _MCitasState extends State<MCitas> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          MyCalendario(),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: kLineaDivisora,
          ),
          MisCitas(),
        ],
      ),
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
          .where("codigo_medico", isEqualTo: currentUser.uid)
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
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatView(
            currentUserId: document["codigo_medico"],
            anotherUserName: document["nombre_paciente"],
            anotherUserId: document["codigo_paciente"],
            appointmentId: document["citaId"],
            isFinished: document['isFinished'],
          ),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: colorTres,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  DateFormat('jm')
                      .format(
                          DateTime.parse(document["fecha"].toDate().toString()))
                      .toString(),
                  style: const TextStyle(
                    fontSize: 10.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${document["nombre_paciente"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      "Síntomas: ${document["sintoma"]}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 9.0,
                        letterSpacing: 1.0,
                        color: colorTres,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
