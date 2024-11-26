import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  final List<Map<String, String>> records = [
    {'title': 'Expense 1', 'amount': '\$50'},
    {'title': 'Expense 2', 'amount': '\$20'},
    {'title': 'Expense 3', 'amount': '\$30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
        backgroundColor: Colors.green,
      ),
      drawer: Maindrawer(),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.pie_chart, color: Colors.green),
              title: Text(records[index]['title']!),
              subtitle: Text('Amount: ${records[index]['amount']}'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Handle record click
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Clicked on ${records[index]['title']}')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add Record Button Clicked')),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
