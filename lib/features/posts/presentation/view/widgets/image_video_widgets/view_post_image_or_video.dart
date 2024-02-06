import 'dart:io';

import 'package:facebook_clone/features/posts/presentation/view/widgets/image_video_widgets/post_video_player.dart';
import 'package:flutter/material.dart';

class ViewPostImagesOrVideo extends StatelessWidget {
  final String fileType;
  final String url;

  const ViewPostImagesOrVideo(
      {super.key, required this.fileType, required this.url});

  @override
  Widget build(BuildContext context) {
    if (fileType == "image") {
      return Image.network(url);
    } else {
      return PostVideoPlayer(url: url);
    }
  }
}
