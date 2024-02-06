import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:facebook_clone/features/posts/presentation/managers/get_all_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'comment_tile.dart';

class CommentsList extends ConsumerWidget {
  final PostModel postModel;

  const CommentsList({super.key, required this.postModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(getAllComments(postModel.postId));
    return Expanded(
      child: comments.when(
        data: (commentsList) {
          if (commentsList.isEmpty) {
            return Container();
          }

          return ListView.builder(
            itemCount: commentsList.length,
            itemBuilder: (context, index) {
              final comment = commentsList.elementAt(index);
              return CommentTile(
                commentModel: comment,
              );
            },
          );
        },
        error: (error, stackTrace) {
          return const Center(child: Icon(Icons.error));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
