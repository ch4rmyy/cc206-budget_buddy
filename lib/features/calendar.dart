import 'package:cc206_budget_buddy/drawers/main_drawer.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_budget_buddy/features/components.dart';

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
  final DateTime _firstDay = DateTime(2023, 1, 1);
  final DateTime _lastDay = DateTime(2029, 12, 31);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]); 
    _loadEventsForDay(_selectedDay!);

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

  void showPopUpDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, //prevent closing when user tap outside
      builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
      ));
      
    Future.delayed(const Duration(seconds: 2)).then((_){
        if(mounted && Navigator.canPop(context)){
          Navigator.of(context).pop();
        }
    });
    
  }

  Future<bool> useAction(BuildContext context) async{
    try{
      await Future.delayed(const Duration(seconds: 1));
      return true;
    }catch(e){
      return false;
    }
  }

  void _addEventDialog(BuildContext context) {
    
  final TextEditingController eventController = TextEditingController();

    showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Plan',
            style: TextStyle(color: Color(0xFF283618), fontSize: 25),
            ),
        
            const SizedBox(height: 10,),
        
            TextField(
              controller: eventController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter Plan',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
              ),
            ),
        
            const SizedBox(height: 5,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, 
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: const Text('Cancel')
                  ),
        
                TextButton(
                  onPressed: () async{
                    FocusScope.of(context).unfocus();
        
                    if(_selectedDay == null){
                showPopUpDialog(context, 'Error', 'Please select a date first.');
                return;
              }
        
              if(eventController.text.trim().isEmpty){
                showPopUpDialog(context, 'Error', 'Plan description cannot be empty!');
                return;
              }
              
              try{
                final userId = await _databaseService.getUserIdFromEmailAndPassword(widget.email, widget.password);
                
                  if (userId == null) {
                    showPopUpDialog(context, 'Error', 'User not found.');
                    return;
                  }
                  setState(() {
                    _selectedEvents.value = _eventsMap[_selectedDay!]??[];
                  });
        
                  int tid = await DatabaseService.instance.addPlans(userId, eventController.text, _selectedDay!);

                  if(tid != -1){
                    final newPlan = Event(
                      tid: tid,
                      description: eventController.text,
                      date: _selectedDay!,
                    );
        
                    setState(() {
                      if(_eventsMap[_selectedDay] == null){
                        _eventsMap[_selectedDay!] = [];
                      }
                      _eventsMap[_selectedDay]!.add(newPlan);
                      _selectedEvents.value = List.from(_eventsMap[_selectedDay]!);
                    });
                    print('Event added $tid');

                    showPopUpDialog(context, 'Success', 'Plan added successfully!');
        
                    eventController.clear();

                  }

                  print('Events for $_selectedDay after adding: ${_eventsMap[_selectedDay]}');
                
                }catch(e){
                  showPopUpDialog(context, 'Error', 'Failed to add plan: $e');
                  print('Error adding plan: $e');
                }
              }, 
              child: const Text('Add')),
              ],
            )
          ],
        ),
      ),
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
                borderRadius: BorderRadius.circular(5),
                boxShadow: [ 
                        BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: const Offset(0 , 2)
                      )]
                ),
              child: TableCalendar<Event>(
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: (day) {
                    print("Events for $day: ${_eventsMap[day]}");
                    print("Loading events for day: $day");
                    return _eventsMap[day]??[];           
                    }, //events for selected day
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    weekendStyle: TextStyle(
                      color: Color(0xFF606C38),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEFAE0)
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 174, 121, 61),
                      borderRadius: BorderRadius.circular(5),
                    ), 
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: const Icon(Icons.chevron_left, color: Color(0xFFFEFAE0),),
                    rightChevronIcon: const Icon(Icons.chevron_right, color: Color(0xFFFEFAE0),)
                  ),

                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      
                      todayDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 179, 118), 
                      shape: BoxShape.circle,
                      ),
                        
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 115, 145, 81),
                        shape: BoxShape.circle,
                      ),
                      
                      weekendTextStyle: TextStyle(color: Color(0xFF606C38)), // Color for weekends
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
                      return const SizedBox.shrink(); 
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
                                  title: const Center(child: Text('Check Plan')),
                                  content: const Text('Are you sure you are done on this plan?'),
                                  actions: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop(false);
                                        }, child: const Text('No'),
                                        ),

                                        TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pop(true);
                                            
                                            _loadEventsForDay(_selectedDay!);
                                          }, 
                                        child: const Text('Yes'),
                                        ),

                                      ],
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
        backgroundColor: const Color(0xFF283618),
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