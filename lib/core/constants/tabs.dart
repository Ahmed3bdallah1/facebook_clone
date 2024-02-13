import 'package:facebook_clone/app/profile_screen.dart';
import 'package:facebook_clone/features/friends/presentation/view/screens/friends_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/posts_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/videos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_constants.dart';

class TabsConstants {
  TabsConstants._();

  static List<Tab> homeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: index == 0 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: index == 1 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2
              ? CupertinoIcons.videocam_circle_fill
              : CupertinoIcons.videocam_circle,
          color: index == 2 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? CupertinoIcons.bell_fill : CupertinoIcons.bell,
          color: index == 3 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 4 ? Icons.account_circle : Icons.account_circle_outlined,
          color: index == 4 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
    ];
  }

  static String userId = FirebaseAuth.instance.currentUser!.uid;

  static List<Widget> screens = [
    const PostsPage(),
    const FriendsScreen(),
    const VideosScreen(),
    const Center(
      child: Text('Notifications Screen'),
    ),
    ProfileScreen(userId: userId),
  ];
}
