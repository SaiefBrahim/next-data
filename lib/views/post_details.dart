import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/controllers/post_screen_controller.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';

import '../models/post.dart';

class PostsDetails extends StatefulWidget {
  const PostsDetails({super.key, required this.post});

  final Post post;

  @override
  PostsDetailsState createState() => PostsDetailsState();
}

class PostsDetailsState extends State<PostsDetails> {
  PostsScreenController postsScreenController =
      Get.find<PostsScreenController>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.light,
        toolbarHeight: 50,
        title: const Text("Post details",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.userIcon,
                  height: 36,
                ),
                const SizedBox(width: 8),
                Text(
                    postsScreenController.usersList
                            .firstWhereOrNull((e) => e.id == widget.post.userId)
                            ?.name ??
                        'UnknownAuthor',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppTheme.primary)),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text( 'Title :',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 8),
                Text(widget.post.title ?? 'No Title',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14,color: AppTheme.base)),
                const SizedBox(height: 8),
                const Text( 'Body :',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 8),
                Text(widget.post.body ?? 'No Description',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14,color: AppTheme.base)),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppImages.postIcon,
                      height: 18,
                    ),
                    const SizedBox(width: 6),
                    Text('POST ID :${widget.post.id.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.base)),
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      AppImages.userDetail,
                      height: 18,
                    ),
                    const SizedBox(width: 6),
                    Text('USER ID :${postsScreenController.usersList
                        .firstWhereOrNull((e) => e.id == widget.post.userId)
                        ?.id}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.base))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
