

import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(authProvider).getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user!.profilePicUrl),
            );
          }

          return const Center(child: Icon(Icons.error));
        });
  }
}
