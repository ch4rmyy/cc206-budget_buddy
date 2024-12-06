import 'package:cc206_budget_buddy/features/log_in.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _obscureText = true;

  final DatabaseService _databaseService = DatabaseService.instance;


  String? _validateEmail(String? value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username.';
    }
    return null;
  }
  
  void _submitForm() async {
    if (_fKey.currentState!.validate()) {
      bool isDuplicate = await _databaseService.checkUserExists(_usernameController.text, _emailController.text);

      if(isDuplicate){
        if(mounted){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Try Again", 
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold)),
                content: const Text(
                  "The email or username is already exists.",
                    textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                            child: const Text("OK", style: TextStyle(fontSize: 16),),
                      ),
                  ),
                ],
              );
            },
          );
        }
      }else{
        try {
          await _databaseService.addUser(
            _emailController.text.trim(),
            _usernameController.text.trim(),
            _passwordController.text.trim(),
          );
    
          _usernameController.clear();
          _emailController.clear();
          _passwordController.clear();
    
          //print sa console
          await _databaseService.printAllUsers();
    
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  width: 40,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(184, 254, 250, 224),
                    border: Border.all(
                    color: const Color.fromARGB(184, 40, 54, 24),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(
                        Icons.check_circle,
                        color: Color.fromRGBO(96, 108, 56, 1),
                        size: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Sign up successful!',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
    
          // Navigate to the Login after delay
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/login');
          });
        } catch (e) {
          // Handle database error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving data: $e')),
          );
        }
      }
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView( // This makes the screen scrollable when the keyboard is visible
        child: Padding(
           padding: const EdgeInsets.all(16.0),  // Add some padding for better spacing
          child: Form(
            key: _fKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(

                  "Budget Buddy",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Create your account",
                  style: TextStyle(fontSize: 15),
                ),
                Image.asset(
                  'assets/images/pig5.png',
                  width: 150,
                  height: 150,
                ),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.person,
                              color: Colors.brown[800],
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 50,
                            width: 250,
                            child: TextFormField(
                              controller: _usernameController,
                              validator: _validateUsername,
                              cursorHeight: 15,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Username',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.email,
                              color: Colors.brown[800],
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 50,
                            width: 250,
                            child: TextFormField(
                              controller: _emailController,
                              validator: _validateEmail,
                              cursorHeight: 15,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.lock,
                              color: Colors.brown[800],
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            width: 250,
                            child: TextFormField(
                              obscureText: _obscureText,
                              controller: _passwordController,
                              validator: _validatePassword,
                              cursorHeight: 15,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? Log in ',
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'here',
                              style: const TextStyle(color: Colors.blue, fontSize: 12),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LogInPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 22, 0, 0),
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromRGBO(238, 235, 212, 1),
                            textStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            minimumSize: const Size(150, 35),
                            elevation: 4,
                          ).copyWith(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text('Sign up', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
