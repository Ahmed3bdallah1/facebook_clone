import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/custom_buttom_transition.dart';
import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:facebook_clone/features/posts/presentation/managers/post_provider.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/comments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/constants/color_constants.dart';
import 'icon_button.dart';

class LikeCommentShare extends ConsumerWidget {
  const LikeCommentShare({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTextButton(
          icon: isLiked
              ? FontAwesomeIcons.solidThumbsUp
              : FontAwesomeIcons.thumbsUp,
          color:
              isLiked ? ColorsConstants.blueColor : ColorsConstants.blackColor,
          label: 'Like',
          onPressed: () {
            ref
                .read(postsProvider)
                .likeAndDislikePosts(postId: post.postId, likes: post.likes);
          },
        ),
        IconTextButton(
          icon: FontAwesomeIcons.solidMessage,
          label: 'Comment',
          onPressed: () {
            Navigator.push(
                context,
                customPageRouteTransition(CommentsScreen(
                  post: post,
                )));
          },
        ),
        const IconTextButton(
          icon: FontAwesomeIcons.share,
          label: 'Share',
        ),
      ],
    );
  }
}
