import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:facebook_clone/features/posts/models/comment_model.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'liked_comment.dart';

class CommentTile extends ConsumerWidget {
  final CommentModel commentModel;

  const CommentTile({super.key, required this.commentModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CommentInfo(commentModel),
          CommentLikes(comment: commentModel),
        ],
      ),
    );
  }
}

class CommentInfo extends ConsumerWidget {
  final CommentModel commentModel;

  const CommentInfo(this.commentModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUsersIdInfoProvider(commentModel.authorId));
    return user.when(data: (userData) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(userId: commentModel.authorId),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: ColorsConstants.messengerBlue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.fullName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(commentModel.text),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }, error: (error, stackTrace) {
      return const Center(child: Icon(Icons.error));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
