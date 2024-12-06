import 'package:cc206_budget_buddy/drawers/about_us.dart';
import 'package:cc206_budget_buddy/drawers/edit_profile.dart';
import 'package:cc206_budget_buddy/drawers/manage_account.dart';
import 'package:cc206_budget_buddy/features/calendar.dart';
import 'package:cc206_budget_buddy/drawers/ratings.dart';
import 'package:cc206_budget_buddy/features/history.dart';
import 'package:cc206_budget_buddy/features/sign_up_page.dart';
import 'package:cc206_budget_buddy/features/homepage.dart';
import 'package:cc206_budget_buddy/features/user_profile.dart';
import 'package:cc206_budget_buddy/input/records.dart';
import 'package:cc206_budget_buddy/navigation/main_navigation.dart';
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
        '/login': (BuildContext ctx) => const LogInPage(),
        '/homepage': (BuildContext ctx) => const Homepage(email: '', password: '',),
        '/signup': (BuildContext ctx) => const SignUpPage(),
        '/nav': (BuildContext ctx) => const MainNavigator(),
        '/rec': (BuildContext ctx) => const Records(),
        '/history': (BuildContext ctx) => const History(email: '', password: '',),
        '/idprofile': (BuildContext ctx) => const ProfileEditorScreen(),
        '/record': (BuildContext ctx) => const Records(),
        '/calendar': (BuildContext ctx) => const Calendar(email: '', password: '',),
        '/manageAcc': (BuildContext ctx) => const ManageAccountPage(),
        '/aboutUs': (BuildContext ctx) => const AboutUsScreen(),
        '/ratings': (BuildContext ctx) => const RatingScreen(),
        '/userprofile': (BuildContext ctx) => const UserProfilePage()
      },
    );
  }
}
