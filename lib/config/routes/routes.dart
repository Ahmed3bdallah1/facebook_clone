import 'package:facebook_clone/app/home_page.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/create_account.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/login_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/add_post_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/comments_screen.dart';
import 'package:facebook_clone/features/posts/presentation/view/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const createAccount = '/create-account';
  static const login = '/login';
  static const home = '/home';
  static const chatScreen = '/chat-screen';
  static const chatsScreen = '/chats-screen';
  static const commentsScreen = '/comments-screen';
  static const createPost = '/create-post';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());

      case createPost:
        return MaterialPageRoute(builder: (_) => const AddPostScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const Login());

      case chatScreen:
        return MaterialPageRoute(builder: (_) => const Login());

      case chatsScreen:
        return MaterialPageRoute(builder: (_) => const Login());

      // case commentsScreen:
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           CommentsScreen(postId: settings.arguments as String));

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());
    }
  }
}
