import 'package:facebook_clone/features/posts/data/repos/posts_repo_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = Provider((ref) {
  return PostsRepoImp();
});