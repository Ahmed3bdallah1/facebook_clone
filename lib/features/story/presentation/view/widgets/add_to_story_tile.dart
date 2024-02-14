import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddStoryTile extends StatelessWidget {
  const AddStoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.createStory);
          },
          child: SizedBox(
            height: 180,
            width: 100,
            child: Stack(
              children: [
                ProfileImageClipRect(
                    userId: FirebaseAuth.instance.currentUser!.uid),
                const Positioned(
                  bottom: 50,
                  left: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.add),
                  ),
                ),
                const Positioned(
                  left: 10,
                  right: 10,
                  bottom: 5,
                  child: Column(
                    children: [
                      Text('Create'),
                      Text('Story'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
