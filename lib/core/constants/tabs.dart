import 'package:facebook_clone/app/profile_screen.dart';
import 'package:facebook_clone/features/friends/presentation/view/screens/friends_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/posts_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/videos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsConstants {
  TabsConstants._();

  static List<Tab> homeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2
              ? CupertinoIcons.videocam_circle_fill
              : CupertinoIcons.videocam_circle,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? CupertinoIcons.bell_fill : CupertinoIcons.bell,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 4 ? Icons.account_circle : Icons.account_circle_outlined,
          color: Colors.blue,
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
