import 'dart:io';

abstract class StoryRepo {
  Future<void> uploadStory({required File file});

  Future<void> viewStory({required String storyId});
}
