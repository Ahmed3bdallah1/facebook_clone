import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/post_widgets/post_tile_info.dart';
import 'package:facebook_clone/features/story/models/story_model.dart';
import 'package:facebook_clone/features/story/presentation/managers/story_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryDetailScreen extends ConsumerStatefulWidget {
  const StoryDetailScreen({
    super.key,
    required this.story,
  });

  final StoryModel story;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    ref.read(storyProvider).viewStory(storyId: widget.story.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.realWhiteColor,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                widget.story.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: PostInfoTile(
              datePublished: widget.story.createdAt,
              userId: widget.story.authorId,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: currentUser == widget.story.authorId
                ? Container(
                    width: 100,
                    height: 50,
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.eye,
                          color: ColorsConstants.realWhiteColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${widget.story.views.length}',
                          style: const TextStyle(
                            color: ColorsConstants.realWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
