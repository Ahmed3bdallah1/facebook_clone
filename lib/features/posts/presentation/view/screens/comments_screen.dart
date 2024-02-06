import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/comment_widgets/comments_list.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/comment_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsScreen extends ConsumerWidget {
  final PostModel post;

  const CommentsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Column(
        children: [
          CommentsList(postModel: post),
          CommentTextField(postId: post.postId)
        ],
      ),
    );
  }
}
