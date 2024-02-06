import 'package:facebook_clone/features/posts/presentation/view/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class TabsConstants {
  TabsConstants._();

  static List<Tab> getHomeScreenTabs(int index) {
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
          index == 2 ? Icons.smart_display : Icons.smart_display_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? Icons.account_circle : Icons.account_circle_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 5 ? Icons.density_medium : Icons.density_medium_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }

  static const List<Widget> screens = [
    PostsPage(),
    // FriendsScreen(),
    // VideosScreen(),
    // ProfileScreen(),
    Center(
      child: Text('friends Screen'),
    ),
    Center(
      child: Text('videos Screen'),
    ),
    Center(
      child: Text('profile Screen'),
    ),
    Center(
      child: Text('Settings Screen'),
    ),
  ];
}
