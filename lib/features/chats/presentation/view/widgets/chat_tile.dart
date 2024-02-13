import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTile extends ConsumerWidget {
  final String chatRoomId;
  final String userId;
  final String lastMessage;
  final DateTime lastMessageTimestamp;

  const ChatTile({
    super.key,
    required this.chatRoomId,
    required this.userId,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUsersIdInfoProvider(userId));
    return user.when(
      data: (data) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.chatScreen,
              arguments: {'userId': userId, 'user': data},
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.4),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      height: 40,
                      width: 40,
                      fit: BoxFit.fitWidth,
                      imageUrl: data.profilePicUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              data.fullName,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "$lastMessage . ",
                                style: const TextStyle(
                                  color: ColorsConstants.darkGreyColor,
                                ),
                              ),
                            ),
                            Text(
                              lastMessageTimestamp.toString().substring(6, 10),
                              style: const TextStyle(
                                color: ColorsConstants.darkGreyColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (error, stacktrace) {
        return Text(error.toString());
      },
      loading: () {
        return Container();
      },
    );
  }
}
