import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
//import 'package:cc206_budget_buddy/input/records.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int currentpage = 0; // Tracks the currently selected page

  // List of pages for navigation
  final List<Widget> pages = [
    const Homepage(),
    Calendar(),
    History(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage], // Display the selected page
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF283618),
        indicatorColor: const Color(0xFFFEFAE0),
        height: 60,
        selectedIndex: currentpage, // Highlight the selected item
        onDestinationSelected: (int index) {
          setState(() {
            currentpage = index; // Update the selected page
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: "Calendar"),
          NavigationDestination(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }




  // @override
  // Widget build(BuildContext context) {
    // return Scaffold(
      // body: pages[currentpage], // Display the selected page
      // bottomNavigationBar: BottomNavigationBar(
        // currentIndex: currentpage, // Track the selected index
        // onTap: (int index) {
          // setState(() {
            // currentpage = index; // Update the selected page
          // });
        // },
        // backgroundColor: Colors.green,
        // selectedItemColor: Colors.white,
        // 
        // showSelectedLabels: false, // Hide the label for selected item
        // showUnselectedLabels: false, // Hide the label for unselected item
        // items: const [
          // BottomNavigationBarItem(
            // icon: Icon(Icons.home),
            // label: "Home", // No label
          // ),
          // BottomNavigationBarItem(
            // icon: Icon(Icons.pie_chart),
            // label: "Calendar", // No label
          // ),
          // BottomNavigationBarItem(
            // icon: Icon(Icons.history),
            // label: "History", // No label
          // ),
        // ],
      // ),
    // );
  // }
  



  // @override
// Widget build(BuildContext context) {
  // return Scaffold(
    // body: pages[currentpage], // Display the selected page
    // bottomNavigationBar: Container(
      // color: Colors.green,
      // height: 50, // Background color for the entire navigation bar
      // child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // children: [
          // _buildNavItem(Icons.home, 0),
          // _buildNavItem(Icons.pie_chart, 1),
          // _buildNavItem(Icons.history, 2),
        // ],
      // ),
    // ),
  // );
// }
// 
// Widget _buildNavItem(IconData icon, int index) {
  // return GestureDetector(
    // onTap: () {
      // setState(() {
        // currentpage = index; // Update the selected page
      // });
    // },
    // child: Container(
      // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      // decoration: BoxDecoration(
        // color: currentpage == index ? Colors.white : Colors.transparent, // Apply color only for the selected item
        // borderRadius: currentpage == index ? BorderRadius.circular(20) : BorderRadius.zero, // Rounded corners only for selected item
        // shape: BoxShape.rectangle, // Ensures it behaves like a rectangle for the selected item
        // boxShadow: currentpage == index
            // ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6, offset: Offset(0, 2))] // Optional shadow for selected item
            // : [],
      // ),
      // child: Icon(
        // icon,
        // color: currentpage == index ? Colors.green : Colors.grey, // Change icon color for selected item
      // ),
    // ),
  // );
// }

}
