import 'package:flutter/material.dart';
import 'package:pry20220116/widgets/medico/bottom_navBar_medico.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/constraints.dart';

class MCitas extends StatefulWidget {
  const MCitas({super.key});

  @override
  _MCitasState createState() => _MCitasState();
}

class _MCitasState extends State<MCitas> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  int index = 0;
  MBottomNavBar? myBNB;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                selectedDay = selectDay;
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
                color: colorSecundario,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(fontSize: 10.0, color: Colors.white),
              defaultTextStyle: TextStyle(fontSize: 10.0),
              holidayTextStyle: TextStyle(fontSize: 10.0),
              disabledTextStyle: TextStyle(fontSize: 10.0),
              weekendTextStyle: TextStyle(fontSize: 10.0),
              outsideTextStyle:
                  TextStyle(fontSize: 10.0, color: Color(0xFFAEAEAE)),
            ),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: kLineaDivisora,
          ),
        ],
      ),
    );
  }
}
