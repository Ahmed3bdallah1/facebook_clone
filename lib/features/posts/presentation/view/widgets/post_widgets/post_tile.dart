import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/image_video_widgets/view_post_image_or_video.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/post_tile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'like_comment_share_item.dart';
import 'likes.dart';

class PostTile extends ConsumerWidget {
  const PostTile({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        PostInfoTile(
          datePublished: post.createdAt,
          userId: post.userId,
        ),
        // Post Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            post.post,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        // Post Video / Image
        if (post.fileUrl != null)
          Center(
            child: ViewPostImagesOrVideo(
              url: post.fileUrl!,
              fileType: post.postType,
            ),
          ),

        // Likes and comment buttons
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          child: Column(
            children: [
              // Likes
              Likes(likes: post.likes),
              const Divider(),
              LikeCommentShare(post: post),
            ],
          ),
        )
      ],
    );
  }
}
