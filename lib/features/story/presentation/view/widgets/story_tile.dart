import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/features/story/models/story_model.dart';
import 'package:flutter/material.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({
    super.key,
    required this.story,
  });

  final StoryModel story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 100,
          width: 110,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: story.imageUrl,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
