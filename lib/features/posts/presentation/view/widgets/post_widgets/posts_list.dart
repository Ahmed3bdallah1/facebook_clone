import 'package:facebook_clone/features/posts/presentation/managers/get_all_posts.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getAllPosts);

    return posts.when(
      data: (postsList) {
        return SliverList.separated(
          itemCount: postsList.length,
          separatorBuilder: (context, index) => Container(
              height: 10, color: Colors.blueGrey.withOpacity(.3)),
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
