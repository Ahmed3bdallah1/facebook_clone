import 'package:facebook_clone/features/chats/presentation/managers/chats_provider.dart';
import 'package:facebook_clone/features/chats/presentation/view/widgets/sent_received_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesList extends ConsumerWidget {
  final String roomId;

  const MessagesList(this.roomId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(getAllMessages(roomId));
    final String myId = FirebaseAuth.instance.currentUser!.uid;
    return chats.when(
      data: (data) {
        if (data.isEmpty) {
          return Container();
        }
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final message = data.elementAt(index);
            final bool isMyMessage = message.senderId == myId;
            if (isMyMessage == false) {
              ref
                  .read(chatsProvider)
                  .seen(roomId: roomId, messageId: message.messageId);
              return ReceivedMessage(message: message);
            }
            return SentMessage(message: message);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 5);
          },
        );
      },
      error: (error, stacktrace) {
        return const Center(child: Icon(Icons.error));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
