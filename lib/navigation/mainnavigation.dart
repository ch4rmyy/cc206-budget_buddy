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
  late String email;
  late String password;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract the arguments passed from the login screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    email = args['email']!;
    password = args['password']!;
  }

  @override
  Widget build(BuildContext context) {
    // Define the list of pages, passing the email and password to the necessary pages
    final List<Widget> pages = [
      Homepage(email: email, password: password), // Pass arguments to homepage
      Calendar(), // No arguments needed for the calendar
      History(email: email, password: password), // Pass to history
    ];


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
}
