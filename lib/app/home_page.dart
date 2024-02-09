import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/core/constants/tabs.dart';
import 'package:facebook_clone/core/widgets/circle_icon_button.dart';
import 'package:facebook_clone/features/auth/presentation/managers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('facebook',
            style: TextStyle(
              color: ColorsConstants.blueColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          const CircleIconButton(
            icon: FontAwesomeIcons.magnifyingGlass,
          ),
          CircleIconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.chatsScreen);
            },
            icon: FontAwesomeIcons.facebookMessenger,
          ),
          CircleIconButton(
            onPressed: () {
              ref.read(authProvider).signOut();
            },
            icon: FontAwesomeIcons.arrowRightFromBracket,
          )
        ],
        bottom: TabBar(
          tabs: TabsConstants.homeScreenTabs(_tabController.index),
          controller: _tabController,
          onTap: (index) {
            setState(() {});
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: TabsConstants.screens,
      ),
    );
  }
}
