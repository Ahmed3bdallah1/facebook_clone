import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:facebook_clone/features/friends/presentation/view/widgets/add_friend.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/icon_button.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
    this.userId,
  });

  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final userData = ref.watch(getUsersIdInfoProvider(userId ?? myUid));
    double width = MediaQuery.of(context).size.width;
    return userData.when(
      data: (user) {
        return SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: Stack(children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 140,
                            color: Colors.grey.withOpacity(.3),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitWidth,
                            imageUrl: user.profilePicUrl,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Values.defaultPadding,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(user.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text("${user.friends.length.toString()} friends",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(height: 10),
                        userId == myUid
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralButton(
                                      width: width * .38,
                                      height: 40,
                                      radius: 6,
                                      icon: CupertinoIcons.plus,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.createStory);
                                      },
                                      label: 'Add to Story'),
                                  GeneralButton(
                                      width: width * .38,
                                      height: 40,
                                      radius: 6,
                                      color: Colors.grey.withOpacity(.3),
                                      icon: Icons.edit,
                                      onPressed: () {},
                                      label: 'Edit Profile'),
                                  GeneralButton(
                                      width: 40,
                                      height: 40,
                                      radius: 6,
                                      icon: Icons.menu,
                                      color: Colors.grey.withOpacity(.3),
                                      onPressed: () {},
                                      label: ''),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AddFriend(
                                    user: user,
                                    width: width * .35,
                                  ),
                                  GeneralButton(
                                      width: width * .35,
                                      height: 40,
                                      radius: 6,
                                      color: Colors.grey.withOpacity(.3),
                                      icon: Icons.edit,
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.chatScreen,
                                          arguments: {
                                            "userId": userId,
                                            "user": user
                                          },
                                        );
                                      },
                                      label: 'Message'),
                                  GeneralButton(
                                      width: 40,
                                      height: 40,
                                      radius: 6,
                                      icon: Icons.menu,
                                      color: Colors.grey.withOpacity(.3),
                                      onPressed: () {},
                                      label: ''),
                                ],
                              ),
                        const SizedBox(height: 10),
                        // userId == myUid
                        //     ? Container()
                        //     : GeneralButton(
                        //         onPressed: () {
                        //           Navigator.of(context).pushNamed(
                        //             Routes.chatScreen,
                        //             arguments: {"userId": userId, "user": user},
                        //           );
                        //         },
                        //         label: 'Send Message',
                        //         color: Colors.transparent,
                        //       ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: 10, color: Colors.blueGrey.withOpacity(.3)),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Values.defaultPadding,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey, thickness: 1),
                        IconTextButton(
                          icon:
                              user.gender == 'male' ? Icons.male : Icons.female,
                          label: user.gender,
                        ),
                        const SizedBox(height: 10),
                        IconTextButton(
                          icon: Icons.cake,
                          label: user.birthDay.toString().substring(0, 10),
                        ),
                        const SizedBox(height: 10),
                        IconTextButton(
                          icon: Icons.email,
                          label: user.email,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: 10, color: Colors.blueGrey.withOpacity(.3)),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.2),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              "Posts",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.indigo),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 12,
                      endIndent: 12),
                ),
                ProfilePosts(userId: userId ?? myUid)
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
