import 'package:flutter/material.dart';

class Maindrawer extends StatelessWidget {
  const Maindrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text("BudgetBuddy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.filter),
                  title: const Text("Preferences",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Edit Profile",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () => Navigator.pushNamed(context, '/idprofile'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
