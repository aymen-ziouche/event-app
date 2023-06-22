import 'package:event_app/providers/userProvider.dart';
import 'package:event_app/screens/auth/login.dart';
import 'package:event_app/screens/home/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);
  static String id = "AuthGate";

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const Login();
        }

        // Render your application if authenticated
        return ChangeNotifierProvider(
            create: (_) => UserProvider(), child: const MainPage());
      },
    );
  }
}
