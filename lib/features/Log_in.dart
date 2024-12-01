import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _fKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;
  final bool _obscureText = true;

  String? _validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  void _submit() async {
    if (_fKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final user =
            await _databaseService.getUserEmailAndPassword(email, password);

        if (user != null) {
          _emailController.clear();
          _passwordController.clear();
          await _popup();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error: No user found")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred. Please try again.")),
        );
      }
    }
  }

  Future<void> _popup() async {
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
              color: const Color(0xFFFEFAE0),
              border: Border.all(
                color: const Color(0xFF283618),
                width: 5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Color.fromRGBO(96, 108, 56, 1), size: 150),
                  SizedBox(height: 20),
                  Text("Log In Successfully",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Delay for 2 seconds, then close dialog and navigate
    // Delay for 2 seconds before navigating
    await Future.delayed(const Duration(seconds: 2));

    // Ensure the widget is still mounted before proceeding
    if (mounted) {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.pushNamed(context, '/nav'); // Navigate to the homepage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add some padding for better spacing
            child: Form(
              key: _fKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    const Text(
                      "BudgetBuddy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Log in on BudgetBuddy",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Image.asset('assets/images/pig5.png',width: 150, height: 150),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                      labelStyle: const TextStyle(fontSize: 12)
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
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
                            labelStyle: const TextStyle(fontSize: 12,)
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? Sign up ',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'here',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromRGBO(238, 235, 212, 1),
                          textStyle: const TextStyle(
                            fontSize: 13,
                          ),
                          minimumSize: const Size(150, 35),
                          elevation: 4,
                        ).copyWith(
                            shape:
                                WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                        child: const Text('Log in',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ]
                ),
            ),
          ),
        ),
      ),
    );
  }
}

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1) 0xFF606C38;
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;
