import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/features/chats/model/message_model.dart';
import 'package:facebook_clone/features/chats/presentation/view/widgets/message.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceivedMessage extends ConsumerWidget {
  final MessagesModel message;

  const ReceivedMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: ColorsConstants.messengerGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Message(message: message),
              ),
            ),
          ),
          const SizedBox(width: 5),
          ProfileImage(userId: message.senderId),
        ],
      ),
    );
  }
}

class SentMessage extends ConsumerWidget {
  final MessagesModel message;

  const SentMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 10,left: 5,right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: ColorsConstants.messengerBlue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          message.seen
                              ? const Icon(
                            Icons.done_all,
                            color: ColorsConstants.whiteColor,
                            size: 16,
                          )
                              : const Icon(
                            Icons.check,
                            color: ColorsConstants.whiteColor,
                            size: 16,
                          ),
                          Text(
                            message.timestamp.toString().substring(10, 16),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Message(
                        message: message,
                        isSentMessage: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
