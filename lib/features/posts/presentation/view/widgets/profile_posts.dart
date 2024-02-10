import 'package:facebook_clone/features/posts/presentation/managers/get_all_posts.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePosts extends ConsumerWidget {
  final String userId;

  const ProfilePosts({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(usersIdPostsProvider(userId));

    return posts.when(
      data: (postsList) {
        print(postsList.length);
        return SliverList.separated(
          itemCount: postsList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final post = postsList.elementAt(index);
            return PostTile(post: post);
          },
        );
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(child: Center(child: Text("error")));
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
