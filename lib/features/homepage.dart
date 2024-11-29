import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
// import 'package:cc206_budget_buddy/features/sign_up_page.dart';
// import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Declare a variable here to manage the state
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        backgroundColor: Colors.green,
      ),
      drawer: Maindrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'greetingText',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Change the greetingText variable when the button is pressed
                setState(() {
                  
                });
              },
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: MainNavigator(),
    );
  }
}
