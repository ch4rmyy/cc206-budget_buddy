import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
  const             Text(
                "Budget Buddy",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
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
                        // Icon(
                        //   Icons.person,
                        //   color: Colors.brown[800],
                        //   size: 25,
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 35,
                          width: 250,
                          child: TextField(
                            cursorHeight: 15,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Username',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.email,
                        //   color: Colors.brown[800],
                        //   size: 25,
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 35,
                          width: 250,
                          child: TextField(
                            cursorHeight: 15,
                            // style: TextStyle(fontSize: 5),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Email',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.password,
                        //   color: Colors.brown[800],
                        //   size: 25,
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 35,
                          width: 250,
                          child: TextField(
                            cursorHeight: 15,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(238, 235, 212, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromRGBO(238, 235, 212, 1),
                          textStyle: const TextStyle(
                            fontSize: 13,
                          ),
                          minimumSize: const Size(250, 35),
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                        ).copyWith(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          )
                            )
                        ),
                        child: const Text('Sign up')
                    ),
                  ],
                ),
              ),
            ], //children
          ),
        ),
    );
  }
}
