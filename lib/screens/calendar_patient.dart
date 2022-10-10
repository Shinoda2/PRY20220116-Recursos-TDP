import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/screens/profile_patient.dart';
import 'package:pry20220116/widgets/nav_bar_patient.dart';
import 'package:pry20220116/widgets/navigation_bar_patient.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../models/cita.dart';
import '../models/medical.dart';

class CalendarPatient extends StatefulWidget {
  const CalendarPatient({Key? key}) : super(key: key);
  @override
  _CalendarPatient createState() => _CalendarPatient();
}

class _CalendarPatient extends State<CalendarPatient> {
  List<Medical> medicals = [];
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

  Future<String> getMedicals() async {
    if (!alreadyRun2) {
      await db.collection('medico').get().then((QuerySnapshot res) {
        res.docs.forEach((doc) {
          medicals.add(
            Medical.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>, null),
          );
          print('Document data doctor: ${doc.data()}');
          print(doc["especialidad_codigo"].toString());
        });
      });
      alreadyRun2 = true;
      return "Success!";
    }
    return ":(";
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
    return Scaffold(
      drawer: NavBarPatient(),
      appBar: AppBar(
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
      body: FutureBuilder<Object>(
          future: Future.wait([getCitas(), getMedicals()]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  TableCalendar(
                    eventLoader: (day) {
                      return _getEventsForDay(day);
                    },
                    focusedDay: _focusedDay,
                    firstDay: DateTime(1920),
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
                  const SizedBox(height: 8.0),
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
                                            onTap: () => print('${cita.fecha}'),
                                            title: Text(medicals[
                                                    cita.codigo_medico! - 1]
                                                .nombre!),
                                            subtitle: Text("Diagnóstico: " +
                                                cita.diagnostico!),
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: NavigationBarPatient(),
    );
  }
}
