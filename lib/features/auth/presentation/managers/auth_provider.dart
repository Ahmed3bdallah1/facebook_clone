import 'package:facebook_clone/features/auth/data/repo/auth_repo_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) {
  return AuthRepoImp();
});
