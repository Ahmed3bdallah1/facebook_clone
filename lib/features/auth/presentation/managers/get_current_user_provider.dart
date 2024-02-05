import 'package:facebook_clone/features/auth/data/repo/auth_repo_imp.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserInfoProvider = FutureProvider.autoDispose<UserModel>((ref) {
  return AuthRepoImp().getUserInfo();
});
