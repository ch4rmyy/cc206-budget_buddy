import 'package:cc206_budget_buddy/drawers/maindrawer.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
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
                      //color: Colors.lightBlue,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("My Money", style: TextStyle(fontSize: 18,color: Colors.white ),),
                          SizedBox(height: 10,),
                          Text("P5000.00", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, color: Colors.white),),
                        ],
                      ),
                    ),
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
                          const Expanded(
                            child: Center(
                              child: Text(
                                "₱3300.00",
                                style: TextStyle(
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
                                Text("Expenses", style: TextStyle(color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
        
                          // Lower part with white color
                          const Expanded(
                            child: Center(
                              child: Text(
                                "₱3300.00",
                                style: TextStyle(
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
        
        
              const SizedBox(height: 50),
        
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                //color: Colors.deepPurple,
                child: const Text("Categories", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold))),
        
              const SizedBox(height: 30),
        
              SizedBox(
                height: 210,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 10),
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
                              offset: Offset(0, 4), // Horizontal and vertical offset
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
          Navigator.pushNamed(context, '/record');
        },
        backgroundColor: Colors.green,
          shape: const CircleBorder(),
        child: const Icon(Icons.add)
      ),
    );
  }
}
