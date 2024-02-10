import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:facebook_clone/features/friends/presentation/managers/friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestTile extends ConsumerWidget {
  const RequestTile({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersIdInfoProvider(userId));

    return user.when(
      data: (userData) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.profileScreen,
                      arguments: userData.uid,
                    );
                  },
                  child: ClipOval(
                    child: CachedNetworkImage(
                      height: 40,
                      width: 40,
                      fit: BoxFit.fitWidth,
                      imageUrl: userData.profilePicUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GeneralButton(
                            onPressed: () {
                              ref
                                  .read(friendsProvider)
                                  .acceptFriendRequest(friendId: userId);
                            },
                            label: 'Confirm',
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GeneralButton(
                            onPressed: () {
                              ref
                                  .read(friendsProvider)
                                  .removeFriendRequest(friendId: userId);
                            },
                            label: 'Delete',
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
