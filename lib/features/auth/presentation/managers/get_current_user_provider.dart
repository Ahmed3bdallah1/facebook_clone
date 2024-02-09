import 'package:facebook_clone/features/auth/data/repo/auth_repo_imp.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserInfoProvider = FutureProvider.autoDispose<UserModel>((ref) {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  return AuthRepoImp().getUserInfo(userId);
});
