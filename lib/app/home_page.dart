import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              ref.read(authProvider).signOut();
            },
            child: Text("log out")),
      ),
    );
  }
}
