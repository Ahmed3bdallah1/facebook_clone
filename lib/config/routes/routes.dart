import 'package:facebook_clone/app/home_page.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/create_account.dart';
import 'package:facebook_clone/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const createAccount = '/create-account';
  static const login = '/login';
  static const home = '/home';
  static const chatScreen = '/chat-screen';
  static const chatsScreen = '/chats-screen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());

      case login:
        return MaterialPageRoute(builder: (_) => const Login());

      case chatScreen:
        return MaterialPageRoute(builder: (_) => const Login());

      case chatsScreen:
        return MaterialPageRoute(builder: (_) => const Login());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());
    }
  }
}
