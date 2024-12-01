import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
//import 'package:cc206_budget_buddy/input/records.dart';
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
    Calendar(),
    History(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage], // Display the selected page
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF283618),
        indicatorColor: const Color(0xFFFEFAE0),
        selectedIndex: currentpage, // Highlight the selected item
        onDestinationSelected: (int index) {
          setState(() {
            currentpage = index; // Update the selected page
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: "Calendar"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
