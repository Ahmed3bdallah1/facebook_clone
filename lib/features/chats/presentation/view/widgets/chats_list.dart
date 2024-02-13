import 'package:facebook_clone/features/chats/presentation/managers/chats_provider.dart';
import 'package:facebook_clone/features/chats/presentation/view/widgets/chat_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsList extends ConsumerWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(getAllChats);
    final String myId = FirebaseAuth.instance.currentUser!.uid;
    return chats.when(
      data: (data) {
        if (data.isEmpty) {
          return Container();
        }
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final chat = data.elementAt(index);
            final userId = chat.members.firstWhere((userId) => userId != myId);
            return ChatTile(
              chatRoomId: chat.chatroomId,
              userId: userId,
              lastMessage: chat.lastMessage,
              lastMessageTimestamp: chat.lastMessageTimeStamp,
            );
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
