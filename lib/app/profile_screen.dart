import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/features/auth/presentation/managers/get_user_provider.dart';
import 'package:facebook_clone/features/friends/presentation/view/widgets/add_friend.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/icon_button.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final userData = ref.watch(usersIdInfoProvider(userId ?? myUid));

    return userData.when(
      data: (user) {
        return SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Values.defaultPadding,
                    child: Column(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitWidth,
                            imageUrl: user.profilePicUrl,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(user.fullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 21)),
                        const SizedBox(height: 20),
                        userId == myUid
                            ? GeneralButton(
                                onPressed: () {}, label: 'Add to Story')
                            : AddFriend(user: user),
                        const SizedBox(height: 10),
                        userId == myUid
                            ? Container()
                            : GeneralButton(
                                onPressed: () {},
                                label: 'Send Message',
                                color: Colors.transparent,
                              ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            IconTextButton(
                              icon: user.gender == 'male'
                                  ? Icons.male
                                  : Icons.female,
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
                      ],
                    ),
                  ),
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
