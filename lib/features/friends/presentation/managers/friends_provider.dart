import 'package:facebook_clone/features/friends/data/friend_repo_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final friendsProvider = Provider((ref) {
  return FriendRepoImp();
});
