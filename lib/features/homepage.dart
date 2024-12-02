import 'dart:ffi';

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
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    _fetchUsername(args['email']!, args['password']!);
  }

  @override
void initState() {
  super.initState();
}

// Fetch total expense and total budget for the user based on username


  Future<void> _fetchUsername(String email, String password) async {
    try {
      final user = await _databaseService.getUserEmailAndPassword(email, password);
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
       remainingMoney = calculateRemainingMoney(budget, expense);  // Correct calculation
             print("Remaining Money: $remainingMoney");
      });
    } else {
      // Handle case where user is not found
      print('User not found');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Maindrawer(),
      backgroundColor: const Color.fromARGB(156, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
        
              Container(
                color: const Color.fromRGBO(40, 54, 24, 1),
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Container(
                      //color: Colors.blueGrey,
                      child: Image.asset("assets/images/pig5.png",width: 120, height: 120)
                      ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
              'Hello, $_username', // Display the username
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
                      const Text(
                        "My Money", 
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        remainingMoney.toStringAsFixed(2), 
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                )

                  ],
                ),
              ),
        
        
              const SizedBox(height: 30,),
        
              Container(
                //color: Colors.cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers columns horizontally
                  children: [
        
                    Container(
                      width: 160,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: Offset(0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part
                      ),
                      child: Column(
                        children: [
                          // Upper part with green color
                          Container(
                            height: 40, // Half the height
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10), // Only top corners rounded
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_downward, color: Colors.white, size: 20),
                                SizedBox(width: 5),
                                Text("Expenses", style: TextStyle(color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
        
                          // Lower part with white color
                          Expanded(
                            child: Center(
                              child: Text(
                                "${totalExpense}",
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
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 8, // Softness of the shadow
                            offset: Offset(0, 4), // Horizontal and vertical offset
                          ),
                        ], // Default color for the lower part // Default color for the lower part
                      ),
                      child: Column(
                        children: [
                          // Upper part with green color
                          Container(
                            height: 40, // Half the height
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10), // Only top corners rounded
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                                SizedBox(width: 5),
                                Text("Budget", style: TextStyle(color: Colors.white, fontSize: 20)),
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
        
        
              const SizedBox(height: 40),
        
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                //color: Colors.deepPurple,
                child: const Text("Categories", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold))),
        
              const SizedBox(height: 30),
        
              SizedBox(
                height: 210,
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
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                           leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),
                      
                      
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),
                      
                      
                      
                      
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),
                      
                      
                      
                      
                      
                      
                      
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),
                      
                      
                      
                      
                      
                      
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          //color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green, // Green on the left
                              Colors.white, // White on the right
                            ],
                            stops: [0.6, 0.5], // Define where each color stops
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
                            ),
                          ], // Default color for the lower part // Default color for the lower part
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.car_crash),
                          title: Text("Transportation"),
                          trailing: Text("P300"),
                        ),
                      ),  
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/record', arguments: {'username' : _username});
        },
        backgroundColor: Colors.green,
          shape: const CircleBorder(),
        child: const Icon(Icons.add)
      ),
    );
  }
}
