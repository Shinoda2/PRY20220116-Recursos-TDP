import 'package:flutter/material.dart';
import 'package:pry20220116/screens/profile.dart';
import 'package:pry20220116/widgets/navigation_bar.dart';
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
  int index=0;
  NavigationBarB ?myBNB;

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
        bottomNavigationBar: NavigationBarB(),
    );
  }
}