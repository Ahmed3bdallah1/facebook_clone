import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_storage.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/story/data/story_repo.dart';
import 'package:facebook_clone/features/story/models/story_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StoryRepoImp extends StoryRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String currentId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> uploadStory({required File file}) async {
    try {
      final storyId = const Uuid().v1();
      final shareTime = DateTime.now();

      Reference ref = _storage.ref(FirebaseStorageFolders.stories).child(storyId);
      TaskSnapshot snapshot = await ref.putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      StoryModel story = StoryModel(
        imageUrl: downloadUrl,
        createdAt: shareTime,
        storyId: storyId,
        authorId: currentId,
        views: [],
      );

      _firestore
          .collection(FirebaseCollectionCategoryName.stories)
          .doc(storyId)
          .set(story.toMap());
    } catch (e) {
      print(e.toString());
      showToastMessage(text: e.toString());
    }
  }

  @override
  Future<void> viewStory({required String storyId}) async {
    try {
      await _firestore
          .collection(FirebaseStorageFolders.stories)
          .doc(storyId)
          .update(
        {
          FirebaseFieldNames.views: FieldValue.arrayUnion([currentId])
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
