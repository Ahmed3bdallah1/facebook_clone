import 'package:facebook_clone/features/friends/presentation/managers/all_friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'friend_tile.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({super.key});

  @override
  ConsumerState<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final friendsList = ref.watch(getAllFriendsProvider);
    return friendsList.when(
      data: (friends) {
        if (friends.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: height * .3,
              child: const Center(
                child: Text("there is no friends yet"),
              ),
            ),
          );
        }

        return SliverList.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final userId = friends.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FriendTile(
                userId: userId,
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
            child: SizedBox(
                height: 300,
                child: Center(child: Icon(Icons.error, size: 40))));
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: SizedBox(
              height: 300, child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
