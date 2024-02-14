import 'dart:io';

import 'package:facebook_clone/core/utils/picker_file.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/features/story/presentation/managers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {
  Future<File?>? imageFuture;

  bool isLoading = false;

  @override
  void initState() {
    imageFuture = pickImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data != null) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Image.file(snapshot.data!),
                ),
                Positioned(
                  bottom: 100,
                  left: 50,
                  right: 50,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GeneralButton(
                          onPressed: () async {
                            setState(() => isLoading = true);
                            await ref
                                .read(storyProvider)
                                .uploadStory(file: snapshot.data!)
                                .then((value) {
                              setState(() => isLoading = false);
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              setState(() => isLoading = false);
                            });
                          },
                          label: 'Post Story',
                        ),
                ),
              ],
            ),
          );
        }

        return const Scaffold(body: Center(child: Text('Image Not Found')));
      },
    );
  }
}
