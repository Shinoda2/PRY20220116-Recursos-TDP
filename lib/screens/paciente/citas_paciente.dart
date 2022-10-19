// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pry20220116/screens/shared/chat_page.dart';
import 'package:pry20220116/utilities/constraints.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/cita.dart';

class PCalendario extends StatefulWidget {
  const PCalendario({Key? key}) : super(key: key);
  @override
  _PCalendario createState() => _PCalendario();
}

class _PCalendario extends State<PCalendario> {
  late final ValueNotifier<List<Cita>> _selectedEvents;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<Cita> citas = [];
  bool alreadyRun1 = false;
  bool alreadyRun2 = false;
  int index = 0;

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
      await db.collection('cita').get().then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          citas.add(
            Cita.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>, null),
          );
          print('Document data cita: ${doc.data()}');
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
      future: getCitas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: [
                TableCalendar(
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
                    todayTextStyle:
                        TextStyle(fontSize: 10.0, color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      color: colorSecundario,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle:
                        TextStyle(fontSize: 10.0, color: Colors.white),
                    defaultTextStyle: TextStyle(fontSize: 10.0),
                    holidayTextStyle: TextStyle(fontSize: 10.0),
                    disabledTextStyle: TextStyle(fontSize: 10.0),
                    weekendTextStyle: TextStyle(fontSize: 10.0),
                    outsideTextStyle:
                        TextStyle(fontSize: 10.0, color: Color(0xFFAEAEAE)),
                  ),
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(_selectedDay, date);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: kLineaDivisora,
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Cita>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView(
                        children: value
                            .map((Cita cita) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.8),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          DateFormat.jm()
                                              .format(cita.fecha!.toDate()),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatView(
                                                currentUserId: cita
                                                    .codigo_paciente!
                                                    .toString(),
                                                anotherUserName:
                                                    cita.nombre_medico!,
                                                anotherUserId: cita
                                                    .codigo_medico!
                                                    .toString(),
                                                appointmentId: cita.citaId!,
                                                isFinished: cita.isFinished!,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            //! Nombre de doctor
                                            "Doctor : ${cita.nombre_medico!}",
                                          ),
                                          subtitle: Text(
                                            "Diagnóstico: ${cita.diagnostico!}",
                                          ),
                                          trailing: Text("Ir al chat"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: [
                TableCalendar(
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
                    todayTextStyle:
                        TextStyle(fontSize: 10.0, color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      color: colorSecundario,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle:
                        TextStyle(fontSize: 10.0, color: Colors.white),
                    defaultTextStyle: TextStyle(fontSize: 10.0),
                    holidayTextStyle: TextStyle(fontSize: 10.0),
                    disabledTextStyle: TextStyle(fontSize: 10.0),
                    weekendTextStyle: TextStyle(fontSize: 10.0),
                    outsideTextStyle:
                        TextStyle(fontSize: 10.0, color: Color(0xFFAEAEAE)),
                  ),
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(_selectedDay, date);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: kLineaDivisora,
                ),
                const Center(
                  child: Text(
                    "No se encontraron citas registradas",
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
