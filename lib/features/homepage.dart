//import 'package:cc206_budget_buddy/features/log_in.dart';
import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
              Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Button Pressed!');
                },
                child: Text('Click Me'),
              ),
            ],
          ),
      ),

      //bottomNavigationBar: MainNavigator(),
    );
  }
}
