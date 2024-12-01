
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_budget_buddy/features/sample.dart';

class Calendar extends StatefulWidget { 
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color(0xFF606C38),
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Color(0xFFFEFAE0)),
      ),
      //drawer: MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 226, 210), 
                borderRadius: BorderRadius.circular(16),
                boxShadow: [ 
                        BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: const Offset(0 , 2)
                      )]
                ),
              // color: const Color(0xFFDDA15E),
              child: TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    // customize tShe UI
                    defaultTextStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      todayDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 234, 187, 135), 
                      shape: BoxShape.circle,
                      ),
                        
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 115, 145, 81),
                        shape: BoxShape.circle,
                      ),
                      
                      weekendTextStyle: TextStyle(color: Color(0xFF283618)), // Color for weekends
                      holidayTextStyle: TextStyle(color: Color.fromARGB(255, 216, 21, 21)), // Color for weekdays
                    
                    outsideDaysVisible: true,
                  ),
                        
                  //December 2024
                  headerStyle: HeaderStyle(
                    titleTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEFAE0)
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 157, 99),
                      borderRadius: BorderRadius.circular(16),
                    )
                  ),
                        
                        
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
            ),
          ),

          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable:_selectedEvents,
              builder: (context, value, _){
                return ListView.builder(itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Color(0xFF606C38), width: 2),
                      color: const Color(0xFFFEFAE0),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [ 
                        BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: const Offset(0 , 2)
                      )]
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
                );
              }
            ))
      ])
    );
  }
}



// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;

// $earth-yellow: rgba(221, 161, 94, 1) 0xFFDDA15E;
// $tigers-eye: rgba(188, 108, 37, 1) 0xFFDDA15E;

// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;