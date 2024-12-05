import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/input/tabs/tab1.dart';
import 'package:cc206_budget_buddy/input/tabs/tab2.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final List<String> categories = [
    "Food",
    "Transportation",
    "School Fees",
    "Wants",
    "Boarding Fees",
    "Others"
  ];

   final DatabaseService _databaseService = DatabaseService.instance;

   @override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Retrieve the username passed from the homepage
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final username = args['username'] as String;  // Get the username

  // Fetch the userId based on the username
  _fetchUserIdByUsername(username);
}

int? _userId;
String? selectedCategory; // Default selected option
final TextEditingController _budgetController = TextEditingController(); //Amount part
final TextEditingController _expenseController = TextEditingController();


// Function to fetch userId by username
Future<void> _fetchUserIdByUsername(String username) async {
  try {
    // Fetch the user data based on username
    final user = await _databaseService.getUserIdByUsername(username);
    if (user != null) {
      setState(() {
        _userId = user['id'];
      });
    // Assuming 'id' is the userId field
      // Now we have the userId, you can call addBudget function // Pass userId to addBudget
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: User not found")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error fetching user")),
    );
    print("Error fetching user: $e");
  }
}

Future<void> _addBudget() async {
  if (_userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error: User not loaded yet")),
    );
    return;
  }

  final double bamount = double.parse(_budgetController.text.trim());

  if (bamount > 0) {
    try {
      await _databaseService.addBudget(_userId!, bamount);
      final double totalBudget = await _databaseService.getTotalBudget(_userId!);  // Assuming this method gets the total budget for the user
    await _databaseService.updateTotalBudget(_userId!, totalBudget);  // Update the total budget in the budget table

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Budget added successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error adding budget")),
      );
      print("Error adding budget: $e");
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a valid amount")),
    );
  }
}

Future<void> _submitDataExpense() async {
  if (_userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error: User not loaded yet")),
    );
    return;
  }

  if (selectedCategory == null || selectedCategory!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select a category")),
    );
    return;
  }

  double? mount; // Nullable until parsed
  try {
    mount = double.parse(_expenseController.text.trim());
    if (mount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Amount must be greater than zero")),
      );
      return;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a valid amount")),
    );
    return;
  }

  try {
    // Call the database service to add the expense
    await _databaseService.addExpense(_userId!, mount, selectedCategory!);
    final double totalExpense = await _databaseService.getTotalExpenses(_userId!);  // Assuming this method gets the total expense for the user
    await _databaseService.updateTotalExpense(_userId!, totalExpense);  // Update the total expense in the user table
    await _databaseService.printAllExpenses();


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Expense added successfully")),
    );

    // Clear inputs after successful submission
    _expenseController.clear();
    setState(() {
      selectedCategory = null; // Reset category
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error adding expense")),
    );
    print("Error adding expense: $e");
  }
}




  
  
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFAE0)),
            onPressed: () {
              // Get the callback from the arguments
              final callback = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

              // If the callback exists, call the function
              if (callback != null && callback['onAddExpense'] != null) {
                callback['onAddExpense'](); // Trigger the refresh
              }

              // Pop the screen and go back to the previous page
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(color: Color(0xFFFEFAE0)),
          title: const Text("Budget Log"),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(254, 250, 224, 1),fontSize: 30,),
          backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
          toolbarHeight: 140,
          flexibleSpace: Container(
              //hello user
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 60),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Text("Hello <user>",style: TextStyle(fontSize: 18, color: Colors.white),),
                      Spacer(),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://ilovelibraries.org/wp-content/uploads/2020/08/libartists-opengraph-768x403.png'),
                      )
                    ])
                  ])),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Expenses()),
              Tab(icon: Budget()),
            ],
            labelColor: Color.fromRGBO(254, 250, 224, 1),
            unselectedLabelColor: Color.fromRGBO(174, 167, 121, 1),
          ),
        ),
        //drawer: const Maindrawer(),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Category",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color.fromARGB(255, 111, 111, 111),fontSize: 20,),
                    ),
                    SizedBox(
                      height: 70,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                        ),
                        elevation: 3, // Shadow effect
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              // Leading Circle Icon
                              const CircleAvatar(radius: 20,
                                backgroundColor: Color.fromRGBO(96, 108, 56, 1), // Green background
                                child: Icon(
                                  Icons.category,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16), // Space between icon and text
                              // Dropdown for Category
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedCategory,
                                    hint: const Text("Select Category",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCategory = newValue;
                                      });
                                    },
                                    items: categories.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Amount",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color.fromARGB(255, 111, 111, 111),fontSize: 20,),
                    ),
                    SizedBox(
                      height: 70,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(20), // Rounded corners
                          ),
                          elevation: 3, // Shadow effect
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(children: [
                                // Empty Space (leading)
                                const SizedBox(width: 16),
                                // Amount TextField
                                Expanded(
                                    child: TextField(
                                  controller: _expenseController,
                                  keyboardType:
                                      TextInputType.number, // Numeric input
                                  decoration: const InputDecoration(
                                    hintText: "Enter Amount",
                                    hintStyle: TextStyle(
                                        color: Colors.grey), // Placeholder text
                                    border: InputBorder
                                        .none, // No border for the text field
                                  ),
                                  style: const TextStyle(fontSize: 16,color: Colors.black,),
                                ))
                              ]))),
                    ),
                    const SizedBox(height: 100,),
                    ElevatedButton(
                      onPressed:
                          _submitDataExpense, // Trigger the function on button press
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF283618), // Button color
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Rounded corners for the button
                        ),
                      ),
                      child: const Text("Add",
                        style: TextStyle(fontSize: 15, color: Color(0xFFFEFAE0)),
                      ),
                    ),
            
                  ],
                )
              ),
          ),


              SingleChildScrollView(
                child: Container(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //const SizedBox(height: 20),
                    const Text("Amount",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color.fromARGB(255, 111, 111, 111),fontSize: 20,),
                    ),
                    SizedBox(
                      height: 70,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(20), // Rounded corners
                          ),
                          elevation: 3, // Shadow effect
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(children: [
                                // Empty Space (leading)
                                const SizedBox(width: 16),
                                // Amount TextField
                                Expanded(
                                    child: TextField(
                                  controller: _budgetController,
                                  keyboardType:
                                      TextInputType.number, // Numeric input
                                  decoration: const InputDecoration(
                                    hintText: "Enter Amount",
                                    hintStyle: TextStyle(
                                        color: Colors.grey), // Placeholder text
                                    border: InputBorder
                                        .none, // No border for the text field
                                  ),
                                  style: const TextStyle(fontSize: 16,color: Colors.black,),
                                ))
                              ]))),
                    ),
                    const SizedBox(height: 100,),
                    ElevatedButton(
                      onPressed: () async {
                        if (_budgetController.text.isNotEmpty) {
                          try {
                            await _addBudget(); // Directly call _addBudget() since it now internally uses _userId
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error: Could not add budget")),
                            );
                            print("Error in button press: $e");
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter a valid amount")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF283618),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 15, color: Color(0xFFFEFAE0)),
                      ),
                    ),

                  ],
                )),
              ),
        ]),
        //bottomNavigationBar: MainNavigator(),
      ),
    );
  }
}


// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1);
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;