import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserInfoAsStreamProvider =
    StreamProvider.autoDispose<UserModel>((ref) {
  final controller = StreamController<UserModel>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.users)
      .where(FirebaseFieldNames.uid,
          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final userData = snapshot.docs.first;
    final user = UserModel.fromMap(userData.data());
    controller.sink.add(user);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
