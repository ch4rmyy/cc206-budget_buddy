import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
// import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
//import 'package:cc206_budget_buddy/features/log_in.dart';
//import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/features/sign_up_page.dart';
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
        backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
      ),
      drawer: Maindrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              
            ),
          ),
        )
      )
    );
  }
}
