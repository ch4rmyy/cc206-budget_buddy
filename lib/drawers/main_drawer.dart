import 'package:flutter/material.dart';

class Maindrawer extends StatelessWidget {
  const Maindrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 230, 226, 200),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Row(
                  children: [
                    Image.asset("assets/images/icon.png", 
                    width: 50, 
                    height: 50,
                    ),

                    const Text("Budget Buddy",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),       
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Manage Account",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () => Navigator.pushNamed(context, '/manageAcc'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_document),
                    title: const Text("Edit Profile",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () => Navigator.pushNamed(context, '/idprofile'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("Rate Budget Buddy",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () => Navigator.pushNamed(context, '/ratings'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded),
                    title: const Text("About Us",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () => Navigator.pushNamed(context, '/aboutUs'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}