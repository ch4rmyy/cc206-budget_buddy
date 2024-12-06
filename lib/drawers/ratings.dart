import 'package:flutter/material.dart';
import 'dart:async';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 0;
  bool _submitted = false;

  void _submitRating() {
    setState(() {
      _submitted = true;
    });
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context); 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(96, 108, 56, 1),
        foregroundColor: const Color(0xFFFEFAE0),
        toolbarHeight: 70,
        title: const Text("Rate Budget Buddy",
        style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: !_submitted
            ? Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 54, 71, 36),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Like BudgetBuddy?',
                      style: TextStyle(
                        color: Color(0xFFFEFAE0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Let us know if you like the app by rating us! Your feedback helps improve the app.',
                      style: TextStyle(color: Color(0xFFFEFAE0)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.yellow,
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 171, 119, 61),
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      ),
                      onPressed: _rating > 0 ? _submitRating : null,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: _rating > 0 ? const Color(0xFFFEFAE0) : Colors.grey,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF283618),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rating submitted successfully',
                      style: TextStyle(
                        color: Color(0xFFFEFAE0),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
