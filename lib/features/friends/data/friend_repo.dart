abstract class FriendRepo {
  Future<void> sendFriendRequest({required String friendId});

  Future<void> acceptFriendRequest({required String friendId});

  Future<void> removeFriendRequest({required String friendId});

  Future<void> deleteFriend({required String friendId});
}
