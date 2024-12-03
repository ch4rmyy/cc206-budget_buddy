import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(96, 108, 56, 1),
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFAE0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: const Text(
                    'About Us',
                    style: TextStyle(color: Color(0xFFFEFAE0), fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/images/icon.png',
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'BudgetBuddy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(188, 108, 37, 1),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Version 1.1.3',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(188, 108, 37, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
