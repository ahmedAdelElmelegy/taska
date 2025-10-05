import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/themes/style.dart';

class CalendarPage extends StatefulWidget {
  final void Function(DateTime)? onDateSelected;
  const CalendarPage({super.key, this.onDateSelected});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now(); // Set initial focus
  DateTime? _selectedDay = DateTime.now(); // Preselect 14th Dec

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Color(0xFFF6FAFD),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(_selectedDay!);
          }
          pop();
        },

        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronVisible: true,
          rightChevronVisible: true,
          titleTextStyle: TextStyles.f18SemiBold,
        ),

        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xFF4C82F6),
            shape: BoxShape.circle,
          ),
          weekendTextStyle: const TextStyle(color: Colors.black54),
          defaultTextStyle: const TextStyle(color: Colors.black87),
          selectedTextStyle: const TextStyle(color: Colors.white),
          todayTextStyle: const TextStyle(color: Colors.black87),
        ),

        daysOfWeekStyle: const DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.black54),
          weekdayStyle: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
