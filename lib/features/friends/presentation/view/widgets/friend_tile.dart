import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendTile extends ConsumerWidget {
  const FriendTile({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersIdInfoProvider(userId));

    return user.when(
      data: (userData) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.profileScreen,
              arguments: userData.uid,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      height: 40,
                      width: 40,
                      fit: BoxFit.fitWidth,
                      imageUrl: userData.profilePicUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    userData.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
