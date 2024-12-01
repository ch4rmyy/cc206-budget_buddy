import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/input/tabs/tab1.dart';
import 'package:cc206_budget_buddy/input/tabs/tab2.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
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
  String? selectedCategory; // Default selected option
  final TextEditingController _amountController =
      TextEditingController(); //Amount part

  // Function to handle button press
  void _submitData() {
    final enteredAmount = _amountController.text;
    if (enteredAmount.isEmpty) {
      // Handle the case where the user hasn't entered anything
      return;
    }
    // Print the entered data to the console (you can replace this with any logic)
    print("Entered Amount: $enteredAmount");
    // Clear the text field after submitting
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFFFEFAE0)),
          title: const Text("Budget Log"),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(254, 250, 224, 1),
            fontSize: 30,
          ),
          backgroundColor: const Color.fromRGBO(40, 54, 24, 1),
          toolbarHeight: 160,
          flexibleSpace: Container(
              //hello user
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 60),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Text("Hello <user>",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
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
        drawer: const Maindrawer(),
        body: TabBarView(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Category",
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
                                controller: _amountController,
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
                        _submitData, // Trigger the function on button press
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
              )),


              Container(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Category",
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
                                controller: _amountController,
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
                        _submitData, // Trigger the function on button press
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
              )),

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