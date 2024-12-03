import 'package:cc206_budget_buddy/drawers/editProfile.dart';
import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/input/records.dart';
import 'package:cc206_budget_buddy/navigation/mainnavigation.dart';
import 'package:cc206_budget_buddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:cc206_budget_buddy/features/log_in.dart';
import 'package:google_fonts/google_fonts.dart';

//para sa database
//import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // Set the global database factory.
  runApp(const MyApp());
  final dbService = DatabaseService.instance;
  await dbService.checkTableInfo();
  await dbService.printAllUsers();
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 163, 227, 90)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      initialRoute: '/login',
      routes: {
        '/login': (BuildContext ctx) => LogInPage(),
        '/homepage': (BuildContext ctx) => const Homepage(),
        '/signup': (BuildContext ctx) => const SignUpPage(),
        '/nav': (BuildContext ctx) => const MainNavigator(),
        '/rec': (BuildContext ctx) => const Records(),
        '/history': (BuildContext ctx) => History(),
        '/idprofile': (BuildContext ctx) => ProfileEditorScreen(),
        '/record': (BuildContext ctx) => const Records(),
        '/calendar': (BuildContext ctx) => Calendar(),

      },
    );
  }
}
