import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/features/chats/model/message_model.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/image_video_widgets/view_post_image_or_video.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    this.isSentMessage = false,
  });

  final MessagesModel message;
  final bool isSentMessage;

  @override
  Widget build(BuildContext context) {
    if (message.messageType == 'text') {
      return Text(
        message.message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isSentMessage
              ? ColorsConstants.whiteColor
              : ColorsConstants.blackColor,
        ),
      );
    } else {
      return ViewPostImagesOrVideo(
        url: message.message,
        fileType: message.messageType,
      );
    }
  }
}
