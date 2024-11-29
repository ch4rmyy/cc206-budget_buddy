//import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/features/records.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int currentpage = 0; // Tracks the currently selected page

  // List of pages for navigation
  final List<Widget> pages = [
    const Homepage(),
    //RecordPage(),
    //HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage], // Display the selected page
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green,
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentpage, // Highlight the selected item
        onDestinationSelected: (int index) {
          setState(() {
            currentpage = index; // Update the selected page
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.pie_chart), label: "Records"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
