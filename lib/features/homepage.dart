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


    double foodSpending = 0.0;
    double transportSpending = 0.0;
    double schoolsSpending = 0.0;
    double boardingsSpending = 0.0;
    double wantsSpending = 0.0;
    double othersSpending = 0.0;


    // void didChangeDependencies() {
      // super.didChangeDependencies();
      // final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      // _fetchUsername(args['email']!, args['password']!);
    // }

    // @override
  // void initState() {
    // super.initState();
    // _fetchUserIdAndCategorySpending();
  // }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      // Extract the arguments and initialize data
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      initializeData(args['email']!, args['password']!);
    }

    Future<void> initializeData(String email, String password) async {
      await _fetchUsername(email, password); // Fetch the username first
      await _fetchUserIdAndCategorySpending(); // Then fetch spending
    }

  Future<void> _fetchUserIdAndCategorySpending() async {
    print("Fetched userId: $_username"); // Debugging line
    final userId = await _databaseService.getUserId(_username); // Fetch the userId using the username
    
    if (userId != null) {
      _fetchCategorySpending(userId); // Fetch category spending once userId is available
    } else {
      print("User not found!");
      // Handle the case when userId is not found
    }
  }

  void _fetchCategorySpending(int userId) async {
    foodSpending = await _databaseService.getTotalSpendingForCategory(userId, "Food");
    transportSpending = await _databaseService.getTotalSpendingForCategory(userId, "Transportation");
    schoolsSpending = await _databaseService.getTotalSpendingForCategory(userId, "School Fees");
    boardingsSpending = await _databaseService.getTotalSpendingForCategory(userId, "Boarding Fees");
    wantsSpending = await _databaseService.getTotalSpendingForCategory(userId, "Wants");
    othersSpending = await _databaseService.getTotalSpendingForCategory(userId, "Others");


    print("Food Spending: $foodSpending"); // Debug
    print("Transport Spending: $transportSpending"); // Debug
    print("School Fees Spending: $schoolsSpending"); // Debug
    print("Boarding Fees Spending: $boardingsSpending"); // Debug
    print("Wants Spending: $wantsSpending"); // Debug
    print("Others Spending: $othersSpending"); // Debug
    

    setState(() {}); // Trigger rebuild when values are updated
  }

    //@override

  // Make sure to pass the userId here



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
          title: const Text("Homepage",),
          backgroundColor: const Color(0xFF606C38),
          foregroundColor: const Color(0xFFFEFAE0),
          toolbarHeight: 70,
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
                        Image.asset("assets/images/pig5.png",width: 120, height: 120),
                        
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                'Hello, $_username', // Display the username
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFEFAE0)),
              ),
                        const Text(
                          "My Money", 
                          style: TextStyle(fontSize: 18, color: Color(0xFFFEFAE0)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          remainingMoney.toStringAsFixed(2), 
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  )

                    ],
                  ),
                ),
          
          
                const SizedBox(height: 30,),
          
                  //color: Colors.cyan,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers columns horizontally
                    children: [
          
                      Container(
                        width: 160,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          color: const Color(0xFFFEFAE0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 189, 186, 165).withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 5, // Softness of the shadow
                              offset: const Offset(0, 2), // Horizontal and vertical offset
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
                                  top: Radius.circular(10), // Only top corners rounded
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_downward, color: Color(0xFFFEFAE0), size: 20),
                                  SizedBox(width: 5),
                                  Text("Expenses", style: TextStyle(color: Color(0xFFFEFAE0), fontSize: 20)),
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
                          ]
                        ),
                      ),
                    
              
              
          
          
          
          
          
          
                      const SizedBox(width: 20), // Optional spacing between columns
          
                      Container(
                        width: 160,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          color: const Color(0xFFFEFAE0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 189, 186, 165).withOpacity(1.0), // Shadow color with opacity
                              spreadRadius: 2, // How much the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(0, 4), // Horizontal and vertical offset
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
                                  top: Radius.circular(10), // Only top corners rounded
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_upward, color: Color(0xFFFEFAE0), size: 20),
                                  SizedBox(width: 5),
                                  Text("Budget", style: TextStyle(color: Color(0xFFFEFAE0), fontSize: 20)),
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
                    ]
                  ),
              
          
          
                const SizedBox(height: 20),
          
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  //color: Colors.deepPurple,
                  child: const Text("Categories", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold))),
          
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
                            borderRadius: BorderRadius.circular(10), // Rounded corners
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
                              color: const Color.fromARGB(255, 189, 186, 165).withOpacity(1.0), // Shadow color with opacity
                                spreadRadius: 2, // How much the shadow spreads
                                blurRadius: 8, // Softness of the shadow
                                offset: const Offset(0, 4), // Horizontal and vertical offset
                              ),
                            ], // Default color for the lower part // Default color for the lower part
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.apple, color: Color(0xFFFEFAE0),),
                            title: const Text("Food", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(foodSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14),),
                            
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
                        ),
                          child: ListTile(
                            leading: const Icon(Icons.car_crash, color: Color(0xFFFEFAE0),),
                            title: const Text("Transportation", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(transportSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
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
                        ),
                          child: ListTile(
                            leading: const Icon(Icons.school, color: Color(0xFFFEFAE0),),
                            title: const Text("School Fees", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(schoolsSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
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
                        ),
                          child: ListTile(
                            leading: const Icon(Icons.star, color: Color(0xFFFEFAE0),),
                            title: const Text("Wants", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(wantsSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
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
                        ),
                          child:ListTile(
                            leading: const Icon(Icons.house, color: Color(0xFFFEFAE0),),
                            title: const Text("Boarding Fees", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(boardingsSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
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
                        ),// Default color for the lower part // Default color for the lower part
                          child: ListTile(
                            leading: const Icon(Icons.category, color: Color(0xFFFEFAE0),),
                            title: const Text("Others", style: TextStyle(color: Color(0xFFFEFAE0), fontWeight: FontWeight.w600),),
                            trailing: Text(othersSpending.toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
                          ),
                      ),
                    ]),
                  )
                )




              ],
              ),
            )
        ),
  
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/record',
                  arguments: {'username': _username});
            },
            backgroundColor: const Color(0xFF283618),
            shape: const CircleBorder(),
            child: const Icon(Icons.add,color: Color(0xFFFEFAE0)),
            ),
           );
  }
}

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1) 0xFFBC6C25;
// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;
