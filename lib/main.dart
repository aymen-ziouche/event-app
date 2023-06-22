import 'package:event_app/screens/auth/login.dart';
import 'package:event_app/screens/auth/register.dart';
import 'package:event_app/screens/home/authgate.dart';
import 'package:event_app/screens/home/homepage.dart';
import 'package:event_app/screens/home/mainpage.dart';
import 'package:event_app/screens/home/reservationspage.dart';
import 'package:event_app/screens/salles/sallesPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: ThemeData(
          primaryColor: Colors.indigo,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: Theme.of(context).textTheme.titleMedium,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          )),
      initialRoute: AuthGate.id,
      routes: {
        MainPage.id: (context) => const MainPage(),
        AuthGate.id: (context) => const AuthGate(),
        HomePage.id: (context) => const HomePage(),
        Login.id: (context) => const Login(),
        Register.id: (context) => const Register(),
        SallesPage.id: (context) => const SallesPage(),
        ReservationsPage.id: (context) => const ReservationsPage(),
      },
    );
  }
}
