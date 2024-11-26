import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  // Sample history records
  final List<Map<String, String>> historyRecords = [
    {'date': '2024-11-01', 'description': 'Bought groceries', 'amount': '\$45'},
    {'date': '2024-11-02', 'description': 'Paid electricity bill', 'amount': '\$100'},
    {'date': '2024-11-03', 'description': 'Dinner at a restaurant', 'amount': '\$60'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.green,
      ),
      drawer: Maindrawer(),
      body: ListView.builder(
        itemCount: historyRecords.length,
        itemBuilder: (context, index) {
          final record = historyRecords[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.history, color: Colors.green),
              title: Text(record['description']!),
              subtitle: Text(record['date']!),
              trailing: Text(
                record['amount']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
