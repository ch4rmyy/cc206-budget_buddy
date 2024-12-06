import 'package:cc206_budget_buddy/drawers/main_drawer.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  final String email;
  final String password;

  const History({super.key, required this.email, required this.password});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var _isLoading = true;
  List<Map<String, dynamic>> _transaction = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactionHistory(); // Fetch the transaction history when the page is loaded
  }

  Future<void> _fetchTransactionHistory() async {
    final dbService = DatabaseService.instance;
    final userId = await dbService.getUserIdFromEmailAndPassword(
        widget.email, widget.password);

    if (userId != null) {
      final transactions = await dbService
          .getTransactionHistory(userId); // Fetch history using the userId
      setState(() {
        _transaction = transactions;
        _isLoading = false; // Set loading to false once the data is fetched
        print("Fetched transactions from database: $_transaction");
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print("User not found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in _transaction) {
      var date = DateTime.parse(transaction['date']).toLocal();
      var dateString = DateFormat('yyyy-MM-dd').format(date);

      groupedTransactions.putIfAbsent(dateString, () => []).add(transaction);
    }

    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('History', style: TextStyle(color: Color(0xFFFEFAE0))),
        backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
        foregroundColor: const Color(0xFFFEFAE0),
        toolbarHeight: 80,
      ),
      drawer: const Maindrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                var date = sortedDates[index];
                var transactions = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        DateFormat('MMM dd, yyyy').format(DateTime.parse(date)),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF606C38),
                        ),
                      ),
                    ),
                    ...transactions.map((transaction) {
                      var amount = transaction['value'] ?? 0.0;
                      var category = transaction['category'] ?? 'Uncategorized';

                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF606C38),
                          child: Icon(Icons.category, color: Color(0xFFFEFAE0)),
                        ),
                        dense: true,
                        title: Text(
                          '$category: \$${amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Time: ${DateFormat('hh:mm a').format(DateTime.parse(transaction['date']).toLocal())}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
    );
  }
}
