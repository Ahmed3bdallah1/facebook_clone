import 'package:facebook_clone/config/routes/routes.dart';
import 'package:facebook_clone/features/story/presentation/managers/story_provider.dart';
import 'package:facebook_clone/features/story/presentation/view/widgets/story_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_to_story_tile.dart';

class StoryListView extends ConsumerWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyData = ref.watch(getAllStories);
    return storyData.when(
      data: (data) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const AddStoryTile();
                  }

                  final story = data.elementAt(index - 1);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.storiesScreen,
                        arguments: data.toList(),
                      );
                    },
                    child: StoryTile(
                      story: story,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 5);
                },
                itemCount: data.isEmpty ? 1 : data.length + 1),
          ),
        );
      },
      error: (error, stacktrace) {
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: Center(
              child: Icon(Icons.error),
            ),
          ),
        );
      },
      loading: () {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: 100,
                    width: 110,
                    child: Container(
                      color: Colors.grey.withOpacity(.1),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
