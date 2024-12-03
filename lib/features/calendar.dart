
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_budget_buddy/features/sample.dart';

class Calendar extends StatefulWidget { 
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  final DatabaseService _databaseService = DatabaseService.instance;

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  String? _username;
  bool _isLoading = true;

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

  // Future<void> _fetchUserByEmail(String email, String password) async {
  //   try{
  //     final user = await _databaseService.getUserEmailAndPassword(email, password);
  //     if (user != null){
  //       setState(() {
  //         _username = user['username'];
  //         _isLoading = false;
  //       });
  //     }
  //   }catch(e){
  //     print("Error fetching user: $e");
  //   }
  // }

  // Future<void> _fetchUserId() async {
  //   if (_username != null){
  //   int? userId = await _databaseService.getUserId(_username!);

  //   if(userId != null){

  //     print ("User ID: $userId.");
  //   }else{
  //     print("User not found");
  //   }
  //   }else{
  //     print ("Username is null. Unable to fetch user ID");
  //   }
  // }

  void _addEventDialog(BuildContext context) {
  final TextEditingController _eventController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Task',
      style: TextStyle(color: Color(0xFF283618), fontSize: 20),
      ),
      content: TextField(
        controller: _eventController,
        decoration: const InputDecoration(hintText: 'Enter task',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            
            if(_selectedDay != null && _eventController.text.isNotEmpty){
              final userId = await _databaseService.getUserId(_username!);

              if(userId != null) {
                await DatabaseService.instance.addPlans(userId, _eventController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Plan added successfully!')),
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User not found.')),
                );
              }

              _eventController.clear();
              Navigator.of(context).pop();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid plan.'))
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Plans'),
        backgroundColor: const Color(0xFF606C38),
        foregroundColor: const Color(0xFFFEFAE0),
        toolbarHeight: 80,
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

                  headerStyle: HeaderStyle(
                    titleTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEFAE0)
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 157, 99),
                      borderRadius: BorderRadius.circular(16),
                    ), 
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: const Icon(Icons.chevron_left, color: Color(0xFFFEFAE0),),
                    rightChevronIcon: const Icon(Icons.chevron_right, color: Color(0xFFFEFAE0),)
                  ),

                  calendarStyle: const CalendarStyle(
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
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final event = value[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEFAE0),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CheckboxListTile(
                        value: false, // Default unchecked state
                        onChanged: (isChecked) async {
                          if (isChecked == true) {
                            // final db = DBHelper();
                            // await db.deleteEvent(event.id); // Delete task from database
                            // // Refresh the event list
                            // _selectedEvents.value =
                            //     await _getEventsForDay(_selectedDay!);
                          }
                        },
                        title: Text(event.title),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedDay != null) {
            _addEventDialog(context);
          } else {
            print("No day selected");
          }
        },
        backgroundColor: Color(0xFF283618),
        elevation: 3,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,
        color: Color(0xFFFEFAE0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 

    );
  }
}



// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;

// $earth-yellow: rgba(221, 161, 94, 1) 0xFFDDA15E;
// $tigers-eye: rgba(188, 108, 37, 1) 0xFFDDA15E;

// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;