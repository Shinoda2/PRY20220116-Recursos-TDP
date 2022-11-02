// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pry20220116/models/cita.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/constraints.dart';
import '../shared/chat_citas.dart';
import '../shared/detalle_cita.dart';

class PCitas extends StatefulWidget {
  const PCitas({super.key});

  @override
  _PCitasState createState() => _PCitasState();
}

class _PCitasState extends State<PCitas> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyCalendario();
  }
}

class MyCalendario extends StatefulWidget {
  const MyCalendario({super.key});

  @override
  State<MyCalendario> createState() => _MyCalendarioState();
}

class _MyCalendarioState extends State<MyCalendario> {
  late final ValueNotifier<List<Cita>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<Cita> citas = [];
  bool alreadyRun1 = false;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<String> getCitas() async {
    if (!alreadyRun1) {
      await FirebaseFirestore.instance
          .collection('cita')
          .where('codigo_paciente', isEqualTo: currentUserId)
          .get()
          .then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          citas.add(
            Cita.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>, null),
          );
        });
      });
      alreadyRun1 = true;
      return "Success!";
    }
    return ":(";
  }

  List<Cita> _getEventsForDay(DateTime day) {
    return citas.where((Cita cita) {
      return isSameDay(cita.fecha!.toDate(), day);
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        //_rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: Future.wait([getCitas()]),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Column(
          children: [
            TableCalendar(
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              focusedDay: _focusedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2050),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder<List<Cita>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView(
                    children:
                        value.map((Cita cita) => CitaItem(cita: cita)).toList(),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CitaItem extends StatelessWidget {
  final Cita cita;
  const CitaItem({Key? key, required this.cita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalleCitaPage(citaId: cita.citaId!),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: colorTres,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  DateFormat.jm()
                      .format(DateTime.parse(cita.fecha!.toDate().toString())),
                  style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      cita.nombre_medico!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      "Síntomas: ${cita.sintoma}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.0,
                        color: colorTres,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.chat_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatView(
                          currentUserId: cita.codigo_paciente!,
                          anotherUserName: cita.nombre_medico!,
                          anotherUserId: cita.codigo_medico!,
                          appointmentId: cita.citaId!,
                          isFinished: cita.isFinished!,
                        ),
                      ),
                    );
                  },
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
