import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostInfoTile extends ConsumerWidget {
  const PostInfoTile({
    Key? key,
    required this.datePublished,
    required this.userId,
  }) : super(key: key);

  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUsersIdInfoProvider(userId));
    return userInfo.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.profileScreen,
                      arguments: user.uid,
                    );
                  },
                  child: user.profilePicUrl == ""
                      ? ClipOval(
                          child: Image.asset(
                          "assets/new_account.jpg",
                          height: 40,
                        ))
                      : ClipOval(
                          child: CachedNetworkImage(
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitWidth,
                              imageUrl: user.profilePicUrl,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error)))),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.profileScreen,
                        arguments: user.uid,
                      );
                    },
                    child: Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    datePublished.toString().substring(5, 16),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/new_account.jpg",
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "unknown",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        );
      },
    );
  }
}
