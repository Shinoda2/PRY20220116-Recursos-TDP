import 'package:flutter/material.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/nav_bar.dart';

class Calendar extends StatefulWidget{
  @override
  _Calendar createState() => _Calendar();

}

class _Calendar extends State<Calendar>{
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Profile()));
              },
            ),
          ],
        ),
      body: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(1920),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format){
          setState(() {
             format = _format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,
        onDaySelected: (DateTime selectDay, DateTime focusDay){
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          print(focusedDay);
      },
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
        selectedDayPredicate: (DateTime date){
          return isSameDay(selectedDay,date);
        },
      ),
    bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today_rounded, size: 30,),
    label: '',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.chat, size: 30),
    label: '',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.playlist_add_check_rounded, size: 30),
    label: '',
    ),
    ],
      selectedItemColor: Colors.blue,
    )
    );
  }
}