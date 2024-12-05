import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_budget_buddy/features/sample.dart';

class Calendar extends StatefulWidget { 
  final String email;
  final String password;

  const Calendar({super.key, required this.email, required this.password}); 

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  final DatabaseService _databaseService = DatabaseService.instance;
  final CalendarConnectors _calendarConnectors = CalendarConnectors();

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime firstDay = DateTime.now();
  DateTime lastDay = DateTime.now().add(const Duration(days: 365 * 12));

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]); 

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  final Map<DateTime, List<Event>> _eventsMap = {};

  Future<void> _loadEventsForDay(DateTime day) async {
    try {
      if(!_eventsMap.containsKey(day)){
        final events = await _calendarConnectors.getEventsForDate(day);
        for (var event in events) {
          print('Fetched event: ${event.tid}, ${event.description}, ${event.date}'); //delete
        }
        setState(() {_eventsMap[day] = events;});
      }
      _selectedEvents.value = List.from(_eventsMap[day]??[]); // Update list

    } catch (e) {
      print('Error loading events: $e');
      _selectedEvents.value = [];
    }
  }  

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _loadEventsForDay(selectedDay);
    }
  }

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
            
            if(_selectedDay != null){
              final userId = await _databaseService.getUserIdFromEmailAndPassword(widget.email, widget.password);

              if(userId != null) {
                await DatabaseService.instance.addPlans(userId, _eventController.text, _selectedDay!);

                setState(() {
                  _selectedEvents.value = _eventsMap[_selectedDay!]??[];
                });

                final newEvent = Event(
                  tid: DateTime.now().millisecondsSinceEpoch,
                  description: _eventController.text,
                  date: _selectedDay!,
                  );

                  setState(() {
                    if(_eventsMap[_selectedDay] == null){
                      _eventsMap[_selectedDay!] = [];
                    }
                    _eventsMap[_selectedDay]!.add(newEvent);
                    _selectedEvents.value = List.from(_eventsMap[_selectedDay]!);
                  });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Plan added successfully!')),
                );
                print('Events for $_selectedDay after adding: ${_eventsMap[_selectedDay]}');
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User not found.')),
                );
              }

              _eventController.clear();
              Navigator.of(context).pop();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid plan.'))
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
      drawer: const Maindrawer(),
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
              child: TableCalendar<Event>(
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: (day) {
                    return _eventsMap[day]??[];
                    }, //events for selected day
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

                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events){
                      if(events.isNotEmpty){
                        return Positioned(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF283618),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink(); //kuhaon ang marker if wala event
                    }
                  ),
     
                  onDaySelected: _onDaySelected,
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
                        value: false,
                        onChanged: (isChecked) async {
                          if (isChecked == true) {

                            bool? confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: const Text('Check Plan'),
                                  content: const Text('Are you sure you are done on this plan?'),
                                  actions: <Widget>[
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop(false);
                                    }, child: const Text('No'),
                                    ),
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop(true);
                                      _loadEventsForDay(_selectedDay!);
                                    }, child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if(confirmDelete == true){

                              try{
                                await _databaseService.deletePlan(event.tid);

                                setState(() {
                                  _eventsMap[_selectedDay!]?.remove(event);
                                });

                                _selectedEvents.value = _eventsMap[_selectedDay!] ?? [];

                                setState(() {
                                  
                                });

                              }catch (e){
                                  print("Erour $e");
                              }
                            }else{
                              setState(() {
                                
                              });
                            }
                          }
                        },
                        title: Text(event.description),
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