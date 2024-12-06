import 'package:cc206_budget_buddy/services/database_service.dart';

class Event {
  final int tid;
  final DateTime date;
  final String description;

  Event({required this.tid, required this.date, required this.description});

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      tid: map['tid'],
      description: map['description'] ?? '', 
      date: DateTime.parse(map['tdate']), 
    );
  }

  @override
  String toString() => description;
}

class CalendarConnectors {
  late DateTime today;
  late DateTime firstDay;
  late DateTime lastDay;

  CalendarConnectors() {
    today = DateTime.now();
    firstDay = DateTime(today.year, today.month - 3, today.day);
    lastDay = DateTime(today.year, today.month + 3, today.day);
  }

  Future<List<Event>> getEventsForDate(DateTime selectedDate) async {
    final DatabaseService _databaseService = DatabaseService.instance;

    final formattedDate = selectedDate.toIso8601String().split('T')[0]; 

    final db = await _databaseService.database;

    try {
      final result = await db.query(
        'tasks',
        where: 'tdate LIKE ?',
        whereArgs: ['$formattedDate%'],
      );

      List<Event> events = result.map((event) => Event.fromMap(event)).toList();

      return events;
    } catch (e) {
      print('Error retrieving events: $e');
      return [];
    }
  }
}
