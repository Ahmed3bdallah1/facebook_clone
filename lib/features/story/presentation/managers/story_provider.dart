import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:facebook_clone/features/story/data/story_repo_imp.dart';
import 'package:facebook_clone/features/story/models/story_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyProvider = Provider((ref) {
  return StoryRepoImp();
});

final getAllStories = StreamProvider.autoDispose((ref) {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final controller = StreamController<Iterable<StoryModel>>();
  final userData = ref.watch(getUsersIdInfoProvider(currentUser));

  userData.whenData((value) {
    final myFriends = [value.uid, ...value.friends];

    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.stories)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .where(FirebaseFieldNames.createdAt,
            isGreaterThan: yesterday.millisecondsSinceEpoch)
        .where(FirebaseFieldNames.authorId, whereIn: myFriends)
        .snapshots()
        .listen((event) {
      final stories = event.docs.map((e) => StoryModel.fromMap(e.data()));
      print("stories length is ");
      print(stories.length);
      controller.sink.add(stories);
    });
    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });
  });
  return controller.stream;
});
