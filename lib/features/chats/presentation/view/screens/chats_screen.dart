import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/widgets/circle_icon_button.dart';
import 'package:facebook_clone/features/chats/presentation/view/widgets/chats_list.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Values.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_outlined),
                          const SizedBox(width: 5),
                          ProfileImage(
                              userId: FirebaseAuth.instance.currentUser!.uid),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CircleIconButton(
                      icon: FontAwesomeIcons.cameraRetro,
                      onPressed: () {
                        // Navigator.of(context).pushNamed(CreateStoryScreen.routeName);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.greyColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.search),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(height: height*.7,child: const ChatsList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
