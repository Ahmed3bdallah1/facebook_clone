import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';

final usersInfoProvider =
    FutureProvider.autoDispose.family<UserModel, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.users)
      .doc(userId)
      .get()
      .then((user) {
    return UserModel.fromMap(user.data()!);
  });
});
