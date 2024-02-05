import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/config/themes/dark_theme.dart';
import 'package:facebook_clone/config/themes/light_theme.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/login_screen.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/verification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class FaceBook extends StatelessWidget {
  const FaceBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook clone',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final User? user = snapshot.data;
            if (user!.emailVerified) {
              return const HomePage();
            } else {
              return const VerificationPage();
            }
          }

          return const Login();
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
