import 'package:facebook_clone/features/story/models/story_model.dart';
import 'package:facebook_clone/features/story/presentation/view/screens/story_details.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoriesScreen extends StatefulWidget {
  final List<StoryModel> stories;

  const StoriesScreen({super.key, required this.stories});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final storyController = StoryController();

  final List<StoryItem> storiesList = [];

  @override
  void initState() {
    super.initState();
    for (final story in widget.stories) {
      final storyView = StoryItem(
        StoryDetailScreen(story: story),
        duration: const Duration(seconds: 10),
      );
      storiesList.add(storyView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: storiesList,
      controller: storyController,
      onComplete: () {
        Navigator.pop(context);
      },
      onVerticalSwipeComplete: (dir) {
        Navigator.pop(context);
      },
    );
  }
}
