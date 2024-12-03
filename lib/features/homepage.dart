//import 'dart:ffi';

import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
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

  String _username = "Guest";
  bool _isLoading = true;

  double totalExpense = 0.0;
  double totalBudget = 0.0;
  double remainingMoney = 0.0;
  double calculateRemainingMoney(double budget, double expense) {
    return budget - expense;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    _fetchUsername(args['email']!, args['password']!);
  }

  @override
  void initState() {
    super.initState();
  }

// Fetch total expense and total budget for the user based on username

  Future<void> _fetchUsername(String email, String password) async {
    try {
      final user =
          await _databaseService.getUserEmailAndPassword(email, password);
      if (user != null) {
        setState(() {
          _username = user['username']; // Fetch username
          _isLoading = false; // Stop loading spinner
        });
        _fetchTotals();
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: User not found.")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching username: $e");
    }
  }

  Future<void> _fetchTotals() async {
    // Get user ID based on the username
    int? userId = await _databaseService.getUserId(_username);

    if (userId != null) {
      // Get total expenses and budget based on the user ID
      double expense = await _databaseService.getTotalExpenses(userId);
      double budget = await _databaseService.getTotalBudget(userId);

      setState(() {
        totalExpense = expense;
        totalBudget = budget;
        remainingMoney =
            calculateRemainingMoney(budget, expense); // Correct calculation
        print("Remaining Money: $remainingMoney");
      });
    } else {
      // Handle case where user is not found
      print('User not found');
    }
  }

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1);
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Homepage",
        ),
        backgroundColor: const Color(0xFF606C38),
        foregroundColor: const Color(0xFFFEFAE0),
        iconTheme: const IconThemeData(color: Color(0xFFFEFAE0)),
        toolbarHeight: 60,
      ),
      drawer: const Maindrawer(),
      backgroundColor: const Color.fromARGB(156, 255, 255, 255),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF606C38),
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  
                      //color: Colors.blueGrey,
                      Image.asset("assets/images/pig5.png",
                          width: 120, height: 120),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello $_username!', // Display the username
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFEFAE0)),
                        ),
                        const Text(
                          "My Money",
                          style: TextStyle(fontSize: 16, color: Color(0xFFFEFAE0)),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          remainingMoney.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              //color: Colors.cyan,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers columns horizontally
                children: [
                  Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      color: const Color(0xFFFEFAE0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(189, 186, 165, 1)
                              .withOpacity(1.0), // Shadow color with opacity
                          spreadRadius: 2, // How much the shadow spreads
                          blurRadius: 5, // Softness of the shadow
                          offset:
                              const Offset(0, 2), // Horizontal and vertical offset
                        ),
                      ], // Default color for the lower part
                    ),
                    child: Column(
                      children: [
                        // Upper part with green color
                        Container(
                          height: 40, // Half the height
                          decoration: const BoxDecoration(
                            color: Color(0xFFBC6C25),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  10), // Only top corners rounded
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward,
                                  color: Color(0xFFFEFAE0), size: 20),
                              SizedBox(width: 5),
                              Text("Expenses",
                                  style: TextStyle(
                                      color: Color(0xFFFEFAE0), fontSize: 20)),
                            ],
                          ),
                        ),

                        // Lower part with white color
                        Expanded(
                          child: Center(
                            child: Text(
                              "$totalExpense",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20), // Optional spacing between columns

                  Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      color: const Color(0xFFFEFAE0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 189, 186, 165)
                              .withOpacity(1.0), // Shadow color with opacity
                          spreadRadius: 2, // How much the shadow spreads
                          blurRadius: 8, // Softness of the shadow
                          offset:
                              const Offset(0, 4), // Horizontal and vertical offset
                        ),
                      ], // Default color for the lower part // Default color for the lower part
                    ),
                    child: Column(
                      children: [
                        // Upper part with green color
                        Container(
                          height: 40, // Half the height
                          decoration: const BoxDecoration(
                            color: Color(0xFF283618),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  10), // Only top corners rounded
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward,
                                  color: Color(0xFFFEFAE0), size: 20),
                              SizedBox(width: 5),
                              Text("Budget",
                                  style: TextStyle(
                                      color: Color(0xFFFEFAE0), fontSize: 20)),
                            ],
                          ),
                        ),

                        // Lower part with white color
                        Expanded(
                          child: Center(
                            child: Text(
                              "$totalBudget",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                //color: Colors.deepPurple,
                child: const Text("Categories",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
            const SizedBox(height: 15),
            SizedBox(
              height: 280,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.car_crash,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "Transportation",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.apple,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "Food",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.school,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "School Fees",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.house,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "Boarding Fees",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "Wants",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        //color: Colors.white,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF606C38), // Green on the left
                            Color(0xFFFEFAE0), // White on the right
                          ],
                          stops: [0.6, 0.5], // Define where each color stops
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 189, 186, 165)
                                .withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: const Offset(
                                0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.category,
                          color: Color(0xFFFEFAE0),
                        ),
                        title: Text(
                          "Others",
                          style: TextStyle(color: Color(0xFFFEFAE0)),
                        ),
                        trailing: Text(
                          "P300",
                          style:
                              TextStyle(color: Color(0xFF000000), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/record',
                arguments: {'username': _username});
          },
          backgroundColor: const Color(0xFF283618),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Color(0xFFFEFAE0),
          )),
    );
  }
}

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1) 0xFFBC6C25;
// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;
