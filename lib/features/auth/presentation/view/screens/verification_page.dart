import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Values.defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeneralButton(
              onPressed: () {
                ref.read(authProvider).verifyEmail().then((value) {
                  if (value == null) {
                    showToastMessage(
                        text: 'Email verification sent to your email');
                  }
                });
              },
              label: 'Verify Email',
            ),
            const SizedBox(height: 20),
            GeneralButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser!;
                await user.reload();
                final emailVerified = user.emailVerified;
                if (emailVerified == true) {
                  Navigator.pushReplacementNamed(context, Routes.home);
                } else {
                  showToastMessage(text: "Your account is not verified yet");
                }
              },
              label: 'Refresh',
            ),
            const SizedBox(height: 20),
            GeneralButton(
              onPressed: () {
                ref.read(authProvider).signOut();
              },
              label: 'Change Email',
            ),
          ],
        ),
      ),
    );
  }
}
