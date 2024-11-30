import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/input/records.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:flutter/material.dart';
import 'package:cc206_budget_buddy/features/log_in.dart';
import 'package:google_fonts/google_fonts.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 163, 227, 90)), 
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      //home: LogInPage(),

      initialRoute: '/rec',
      routes: {
        '/login': (BuildContext ctx ) => LogInPage(),
        '/homepage' : (BuildContext ctx) => const Homepage(),
        '/signup' : (BuildContext ctx) => const SignUpPage(),
        '/nav': (BuildContext ctx ) =>  MainNavigator(),
        '/rec':(BuildContext ctx ) => const Records(),
      },
    );
  }
}
