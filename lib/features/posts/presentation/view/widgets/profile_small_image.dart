import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImage extends ConsumerWidget {
  final String userId;

  const ProfileImage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(authProvider).getUserInfo(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ClipOval(
              child: Image.asset(
                "assets/new_account.jpg",
                height: 40,
                width: 40,
              ),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.profileScreen,
                  arguments: user.uid,
                );
              },
              child: ClipOval(
                child: CachedNetworkImage(
                  height: 40,
                  width: 40,
                  fit: BoxFit.fitWidth,
                  imageUrl: user!.profilePicUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          }

          return SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(child: Image.asset("assets/new_account.jpg")));
        });
  }
}
