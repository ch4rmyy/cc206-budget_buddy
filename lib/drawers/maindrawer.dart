import 'package:flutter/material.dart';

class Maindrawer extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Color.fromRGBO(0, 0, 0, 0.612),
      
      child: Column(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text("BudgetBuddy", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,)
              ),
            ),
          ),

          Container(
             child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Preferences",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                  )
                ],
             ),
          ),
        ],
      ),
    );
  }
}