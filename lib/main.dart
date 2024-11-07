import 'package:flutter/material.dart';
import 'package:cc206_budget_buddy/features/log_in.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: LogInPage(),

      initialRoute: '/login',
      routes: {
        '/login': (BuildContext ctx ) => LogInPage(),
        '/simplehomepage' : (BuildContext ctx) => HomePage()
      },
    );
  }
}
