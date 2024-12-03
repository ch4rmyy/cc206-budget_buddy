import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

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
      drawer: const Maindrawer(),
      body: pages[currentpage], 
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: Color(0xFF283618),
          indicatorColor: Color.fromRGBO(221, 161, 94, 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: currentpage,
          onDestinationSelected: (int index) {
            setState(() {
              currentpage = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Color(0xFFFEFAE0)),
              label: '',
              
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month, color: Color(0xFFFEFAE0)),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.history, color: Color(0xFFFEFAE0)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
  // /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1);
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;
}
