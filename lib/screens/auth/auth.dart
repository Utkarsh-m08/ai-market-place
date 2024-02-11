
import 'package:drone_market/screens/homePage/navBar.dart';
import 'package:drone_market/screens/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class auth extends StatelessWidget {
  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // check if user logged in
          if (snapshot.hasData) {
            return navBar();
            // Navigator.pop(context);
          }

          // user is not logged in
          else {
            return landing();
          }
        },
      ),
    );
  }
}
