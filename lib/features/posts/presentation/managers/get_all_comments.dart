import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/posts/models/comment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllComments = StreamProvider.autoDispose
    .family<Iterable<CommentModel>, String>((ref, postId) {
  final controller = StreamController<Iterable<CommentModel>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.comments)
      .where(FirebaseFieldNames.postId, isEqualTo: postId)
      .orderBy(FirebaseFieldNames.createdAt, descending: true)
      .snapshots()
      .listen((event) {
    final comments = event.docs.map(
      (commentData) => CommentModel.fromMap(
        commentData.data(),
      ),
    );
    controller.sink.add(comments);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
