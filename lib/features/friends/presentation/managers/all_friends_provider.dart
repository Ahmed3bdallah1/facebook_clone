import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/firebase_constants/firebase_collection_category_name.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllFriendsProvider = StreamProvider.autoDispose((ref) {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final controller = StreamController<Iterable<String>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionCategoryName.users)
      .doc(userId)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.exists) {
      final userData = snapshot.data();
      final user = UserModel.fromMap(userData!);
      final friends = user.friends;
      print(friends.length);
      controller.sink.add(friends);
    } else {
      controller.sink.add([]);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
