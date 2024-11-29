import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:flutter/material.dart';
import 'package:cc206_budget_buddy/features/log_in.dart';

//para sa database 
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//import 'package:path_provider/path_provider.dart';



void main() {
   // Set the global database factory.
  runApp(const MyApp());
  sqfliteFfiInit();  // Initialize sqflite FFI.
  databaseFactory = databaseFactoryFfi; 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

      initialRoute: '/signup',
      routes: {
        '/login': (BuildContext ctx ) => LogInPage(),
        '/simplehomepage' : (BuildContext ctx) => const Homepage(),
        '/signup' : (BuildContext ctx) => const SignUpPage(),
        '/nav': (BuildContext ctx ) =>  MainNavigator(),
      },
    );
  }
}
