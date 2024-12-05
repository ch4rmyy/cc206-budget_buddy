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

  // Fetch transaction history from the database
  Future<void> _fetchTransactionHistory() async {
    final dbService = DatabaseService.instance;
    final userId = await dbService.getUserIdFromEmailAndPassword(widget.email, widget.password);

    if (userId != null) {
      final transactions = await dbService.getTransactionHistory(userId); // Fetch history using the userId
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
  // @override
  // Widget build(BuildContext context) {
    // return SafeArea(
      // child: Scaffold(
        // appBar: AppBar(
          // title: const Text('History', style: TextStyle(color: Color(0xFFFEFAE0)),),
          // backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
          // toolbarHeight: 100,
        // ),
        // body:  _isLoading
            // ? const Center(child: CircularProgressIndicator()) // Show loading spinner while data is being fetched
            // : ListView.builder(
                // padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                // itemCount: _transaction.length,
                // itemBuilder: (context, index) {
                  // var transaction = _transaction[index]; // Get the transaction data
                  // var date = transaction['date']; // Assuming 'date' is a field in the transaction
                  // var amount = transaction['value']  ?? 0.0; // Assuming 'amount' is a field in the transaction
                  // var category = transaction['category'] ?? 'Uncategorized'; // Assuming 'category' is a field in the transaction
                  // if (transaction['type'] == 'Budget' && category == 'Uncategorized') {
                    // category = 'Budget'; // Default to "Budget" for uncategorized budgets
                  // }
                  // print("Displaying: category=$category, amount=$amount");
// 
// 
                  // return ListTile(
                    // contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    // leading: const CircleAvatar(
                      // backgroundColor: Color(0xFF606C38),
                      // child: Icon(Icons.category, color: Color(0xFFFEFAE0)),
                    // ),
                    // dense: true,
                    // title: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // children: [
                        // Text(
                          // '$category: \$${amount.toStringAsFixed(2)}', // Display category and amount
                          // style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // 
                      // ],
                      // 
                    // ),
                    // subtitle: Text(
                      // 'Date: $date',
                      // style: const TextStyle(color: Colors.grey),
                    // ),
                  // );
                // },
              // ),
      // ),
    // );
  // }


















@override
Widget build(BuildContext context) {
  // Step 1: Group transactions by date (date portion only)
  final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
  for (var transaction in _transaction) {
    // Extract the date portion (e.g., "2024-12-05") and group by it
    var date = DateTime.parse(transaction['date']).toLocal();
    var dateString = DateFormat('yyyy-MM-dd').format(date);

    groupedTransactions.putIfAbsent(dateString, () => []).add(transaction);
  }

  // Step 2: Sort the dates in descending order (latest date first)
  final sortedDates = groupedTransactions.keys.toList()
    ..sort((a, b) => b.compareTo(a));

  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: const Text('History', style: TextStyle(color: Color(0xFFFEFAE0))),
        backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
        toolbarHeight: 100,
      ),
       drawer: const Maindrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                var date = sortedDates[index]; // Get the date string (e.g., "2024-12-05")
                var transactions = groupedTransactions[date]!; // Get transactions for this date

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
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
                    // Transactions for the date
                    ...transactions.map((transaction) {
                      var amount = transaction['value'] ?? 0.0;
                      var category = transaction['category'] ?? 'Uncategorized';

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF606C38),
                          child: Icon(Icons.category, color: Color(0xFFFEFAE0)),
                        ),
                        dense: true,
                        title: Text(
                          '$category: \$${amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
    'Time: ${DateFormat('hh:mm a').format(DateTime.parse(transaction['date']).toLocal())}', // Format the time as hh:mm AM/PM
    style: const TextStyle(color: Colors.grey),
  ),
                      );
                    })
                  ],
                );
              },
            ),
    ),
  );
}

}
