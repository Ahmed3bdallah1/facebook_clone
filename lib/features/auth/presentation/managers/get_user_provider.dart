import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';

final getUsersIdInfoProvider =
    StreamProvider.autoDispose.family<UserModel, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.users)
      .doc(userId)
      .snapshots()
      .map((event) {
    return UserModel.fromMap(event .data()!);
  });
});
