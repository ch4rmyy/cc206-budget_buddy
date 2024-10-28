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
  List<Map<String, String>> budgetBuddyUsers = [];
  bool _obscureText = true;

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

  void _submitForm() {
    if (_fKey.currentState!.validate()) {
      setState(() {
        budgetBuddyUsers.add({
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });
      });

      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign Up successful!'),
          backgroundColor: Color.fromARGB(255, 65, 155, 68)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _fKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Budget Buddy",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                          )),
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
                              )),
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
                          )),
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
                              )),
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
                          )),
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
                            labelStyle: const TextStyle(
                              fontSize: 12,
                            ),
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.brown[800],
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromRGBO(238, 235, 212, 1),
                          textStyle: const TextStyle(
                            fontSize: 13,
                          ),
                          minimumSize: const Size(100, 35),
                          elevation: 4,
                        ).copyWith(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('Sign up')),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(80, 15, 0, 15),
                    child: Text('Already have an account? Log in here.',
                    style:  TextStyle(fontSize: 11),
                    )
                  )


                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
