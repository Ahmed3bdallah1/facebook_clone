import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/core/utils/picker_file.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:facebook_clone/features/chats/presentation/managers/chats_provider.dart';
import 'package:facebook_clone/features/chats/presentation/view/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends ConsumerWidget {
  final String userId;
  final UserModel user;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    String roomId = "";

    return FutureBuilder<String>(
        future: ref.watch(chatsProvider).createChatRoom(userId: userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text("Oops, something went wrong"));
          }

          roomId = snapshot.data ?? '';
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: ColorsConstants.messengerBlue,
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.fitWidth,
                          imageUrl: user.profilePicUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                ),
                leadingWidth: 80,
                titleSpacing: 0,
                title: Text(user.fullName)),
            body: Column(
              children: [
                Expanded(child: MessagesList(roomId)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        color: ColorsConstants.messengerDarkGrey,
                      ),
                      onPressed: () async {
                        final image = await pickImage();
                        if (image == null) return;
                        await ref.read(chatsProvider).sendFile(
                              file: image,
                              roomId: roomId,
                              receiverId: userId,
                              fileType: 'image',
                            );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.video,
                        color: ColorsConstants.messengerDarkGrey,
                        size: 20,
                      ),
                      onPressed: () async {
                        final video = await pickVideo();
                        if (video == null) return;
                        await ref.read(chatsProvider).sendFile(
                              file: video,
                              roomId: roomId,
                              receiverId: userId,
                              fileType: 'video',
                            );
                      },
                    ),
                    // Text Field
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorsConstants.messengerGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Aa',
                            hintStyle: TextStyle(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              bottom: 10,
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: ColorsConstants.messengerBlue,
                      ),
                      onPressed: () async {
                        await ref.read(chatsProvider).sendMessage(
                              message: controller.text,
                              roomId: roomId,
                              receiverId: userId,
                            );
                        controller.clear();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
