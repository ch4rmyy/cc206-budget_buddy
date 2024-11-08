import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/features/log_in.dart';
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
  List<Map<String, String>> budgetBuddyUsers = [];
  final bool _obscureText = true;

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

      showDialog(context: context, builder: (BuildContext context){
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
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign up successful!', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.check_circle, color: Color.fromARGB(255, 32, 216, 38), size: 150,),
                SizedBox(height: 20,)
              ],
            ),
          ), 
        );

      },
      );
      //Delay for 2 sec tas next page TRY LNG
        Future.delayed(const Duration(seconds: 2), (){
          if (!mounted) return; //check ya if ara pa si signUpPage before magNavigate sa new page 
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=> const Homepage()),
            );
        });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Sign Up successful!'),
      //     backgroundColor: Color.fromARGB(255, 65, 155, 68)));
    }

  } // Submit form function

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
                  const SizedBox(height: 5),

                  RichText( //Widget para magDisplay text nga may lainlain design gamit ang TextSpan class 
                    text: TextSpan( //proprty sang text
                      text: 'Already have an account? Log in ',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(color: Colors.blue, fontSize: 12),

                          recognizer: TapGestureRecognizer() //property sang textSpan for linking sa LogIn
                            ..onTap = () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage ())); //Change sa LogInPage ang Homepage
                            }
                          
                        )
                      ]
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 22, 0, 0),
                    child: ElevatedButton(
                        onPressed: _submitForm, 
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
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('Sign up', style: TextStyle(fontWeight: FontWeight.w600),)),
                  ),
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
