import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/core/constants/tabs.dart';
import 'package:facebook_clone/core/widgets/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          )
        ],
        bottom: TabBar(
          tabs: TabsConstants.getHomeScreenTabs(_tabController.index),
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
