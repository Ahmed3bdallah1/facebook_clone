import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/features/friends/presentation/view/widgets/friends_list.dart';
import 'package:facebook_clone/features/friends/presentation/view/widgets/requests_list.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: Values.defaultPadding,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              'Requests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          RequestsList(),
          SliverToBoxAdapter(
            child: Divider(height: 40, thickness: 2),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Friends',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          FriendsList(),
        ],
      ),
    );
  }
}
