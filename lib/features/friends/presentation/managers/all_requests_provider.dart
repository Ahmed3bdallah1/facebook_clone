import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_field_names.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllFriendRequests = StreamProvider.autoDispose((ref) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  final controller = StreamController<Iterable<String>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.users)
      .where(FirebaseFieldNames.uid, isEqualTo: myUid)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.first;
      final user = UserModel.fromMap(userData.data());
      controller.sink.add(user.receivedRequests);
    } else if (snapshot.docs.isEmpty || snapshot.docs == null) {
      controller.sink.add([]);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
