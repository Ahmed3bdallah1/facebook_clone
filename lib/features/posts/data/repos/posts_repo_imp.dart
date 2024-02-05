import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/posts/data/repos/posts_repo.dart';
import 'package:facebook_clone/features/posts/models/comment_model.dart';
import 'package:facebook_clone/features/posts/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostsRepoImp extends PostsRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String?> post(
      {required String post,
      required File file,
      required String postType}) async {
    try {
      final String postId = const Uuid().v1();
      print(postId);
      final String userId = _auth.currentUser!.uid;
      final DateTime shareTime = DateTime.now();

      final path = _storage.ref(postType).child(postId);
      final taskSnapshot = await path.putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      PostModel postModel = PostModel(
          postId: postId,
          userId: userId,
          post: post,
          postType: postType,
          fileUrl: downloadUrl,
          createdAt: shareTime,
          likes: []);

      _firestore
          .collection(FirebaseCollectionCategoryName.posts)
          .doc(postId)
          .set(postModel.toMap());

      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> comment(
      {required String text, required String postId}) async {
    try {
      final String commentId = const Uuid().v1();
      final String userId = _auth.currentUser!.uid;
      final DateTime commentingTime = DateTime.now();

      CommentModel comment = CommentModel(
        commentId: commentId,
        authorId: userId,
        postId: postId,
        text: text,
        createdAt: commentingTime,
        likes: const [],
      );

      _firestore
          .collection(FirebaseCollectionCategoryName.comments)
          .doc(postId)
          .set(comment.toMap());

      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  @override
  Future<String?> likeAndDislikePosts(
      {required String postId, required List<String> likes}) async {
    try {
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String?> likeDislikeComment(
      {required String commentId, required List<String> likes}) {
    // TODO: implement likeDislikeComment
    throw UnimplementedError();
  }
}
