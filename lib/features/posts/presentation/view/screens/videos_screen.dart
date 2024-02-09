import 'package:facebook_clone/features/posts/presentation/managers/get_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/post_widgets/post_tile.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(getAllVideos);
    return videos.when(
      data: (videosList) {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = videosList.elementAt(index);
                  return Column(
                    children: [
                      PostTile(post: video),
                      const SizedBox(height: 8),
                    ],
                  );
                },
                childCount: videosList.length,
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
