import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllPosts = StreamProvider<Iterable<PostModel>>((ref) {
  final controller = StreamController<Iterable<PostModel>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.posts)
      .orderBy(FirebaseFieldNames.datePublished, descending: true)
      .snapshots()
      .listen((snapshot) {
    final posts = snapshot.docs.map(
      (postData) => PostModel.fromMap(
        postData.data(),
      ),
    );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});

final usersIdPostsProvider =
    StreamProvider.autoDispose.family<Iterable<PostModel>, String>(
  (ref, userId) {
    final controller = StreamController<Iterable<PostModel>>();
    FirebaseFirestore.instance
        .collection(FirebaseCollectionCategoryName.posts)
        .where(FirebaseFieldNames.posterId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        final posts = snapshot.docs.map(
          (postData) => PostModel.fromMap(postData.data()),
        );
        print(posts.length);
        controller.sink.add(posts);
      },
    );

    return controller.stream;
  },
);
