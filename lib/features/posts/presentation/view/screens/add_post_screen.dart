import 'dart:io';
import 'package:facebook_clone/core/constants/color_constants.dart';
import 'package:facebook_clone/core/constants/values.dart';
import 'package:facebook_clone/core/utils/picker_file.dart';
import 'package:facebook_clone/core/widgets/bottom.dart';
import 'package:facebook_clone/core/widgets/toast.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/image_video_widgets/image_video_container.dart';
import 'package:facebook_clone/features/posts/presentation/view/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../managers/post_provider.dart';
import '../widgets/pick_image_video.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  late final TextEditingController controller;
  File? file;
  String fileType = 'image';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  Future<void> uploadPost() async {
    setState(() => isLoading = true);
    await ref
        .read(postsProvider)
        .post(
          post: controller.text,
          file: file!,
          postType: fileType,
        )
        .then((value) {
      print(value);
      showToastMessage(text: "post uploaded successfully");
      Navigator.pop(context);
    }).catchError((e) {
      showToastMessage(text: e.toString());
      setState(() => isLoading = false);
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsConstants.greyColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: TextButton(
                onPressed: uploadPost,
                child: const Text('Post'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Values.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileInfo(),
              // post text field
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: ColorsConstants.darkGreyColor,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
              ),
              const SizedBox(height: 20),
              file != null
                  ? ImageVideoContainer(fileType: fileType, file: file!)
                  : PickImageOrVideo(
                      pickImage: () async {
                        fileType = 'image';
                        file = await pickImage();
                        setState(() {});
                      },
                      pickVideo: () async {
                        fileType = 'video';
                        file = await pickVideo();
                        setState(() {});
                      },
                    ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GeneralButton(
                      onPressed: uploadPost,
                      label: 'Post',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
