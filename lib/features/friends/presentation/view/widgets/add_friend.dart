import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../managers/friends_provider.dart';

class AddFriend extends ConsumerStatefulWidget {
  const AddFriend({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  ConsumerState<AddFriend> createState() => _AddFriendButtonState();
}

class _AddFriendButtonState extends ConsumerState<AddFriend> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final requestSent = widget.user.receivedRequests.contains(myUid);
    final requestReceived = widget.user.sentRequests.contains(myUid);
    final alreadyFriend = widget.user.friends.contains(myUid);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : GeneralButton(
            onPressed: requestReceived
                ? null
                : () async {
                    setState(() => isLoading = true);
                    final provider = ref.read(friendsProvider);
                    final userId = widget.user.uid;
                    if (requestSent) {
                      // cancel request
                      await provider.removeFriendRequest(friendId: userId);
                    } else if (alreadyFriend) {
                      // remove friendship
                      await provider.deleteFriend(friendId: userId);
                    } else {
                      // sent friend request
                      await provider.sendFriendRequest(friendId: userId);
                    }
                    setState(() => isLoading = false);
                  },
            label: requestSent
                ? 'Cancel Request'
                : alreadyFriend
                    ? 'Remove Friend'
                    : 'Add Friend',
          );
  }
}
