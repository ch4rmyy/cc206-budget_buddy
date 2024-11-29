import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:login/features/homepage.dart';


class LogInPage extends StatelessWidget {
  // Define the formKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService.instance;

  // Email validation function
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation function
  String? validatePassword(String? password) {
    if (password == null || password.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  Future<void> _popup(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 75,
          height: 300,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(254, 250, 224, 100),
            border: Border.all(
              color: const Color.fromRGBO(96, 108, 56, 100),
              width: 5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Icon(Icons.check_circle, color: Color.fromARGB(255, 32, 216, 38), size: 150),
                  SizedBox(height: 20),
                  Text("Log In Successfully", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,)),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Delay for 3 seconds, then close the dialog and navigate
  await Future.delayed(const Duration(seconds: 2), () {
    Navigator.pop(context); // Close the dialog
    Navigator.pushNamed(context, '/nav'); // Navigate to the homepage
  }); 
}
  LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //reason for back button 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Form(
                // Wrap the Column with the Form widget
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      child: const Text(
                        "BudgetBuddy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: const Text(
                        "Log in on BudgetBuddy",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Image.asset('assets/images/pig5.png',
                          width: 150, height: 150),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 250,
                      height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(238, 235, 212, 100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail, // Email validator
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 250,
                      height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(238, 235, 212, 100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: validatePassword, // Password validator
                      ),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _popup(context);                          
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 70, vertical: 5),
                        child: Text('Login',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Forgot Password? ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Click Here',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Click Here tapped');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
