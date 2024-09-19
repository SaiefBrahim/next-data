import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/models/post.dart';
import 'package:next_data_saief_brahim/views/post_details.dart';

class PostCard extends StatefulWidget {
  final double elevation;
  final String? user;
  final int? height;
  final Post post;

  const PostCard(
      {super.key,
      this.elevation = 1,
      this.user,
      this.height,
      required this.post});

  @override
  PostCardState createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Card(
      color: AppTheme.light,
      margin: const EdgeInsets.all(8),
      elevation: widget.elevation,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.userIcon,
                  height: 31,
                ),
                const SizedBox(width: 8),
                Text(widget.user ?? 'UnknownAuthor',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.primary)),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.post.title ?? 'No Title',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12)),
                Text(widget.post.body ?? 'No Description',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppImages.postIcon,
                      height: 15,
                    ),
                    const SizedBox(width: 6),
                    Text('POST ID :${widget.post.id.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.base))
                  ],
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => PostsDetails(post: widget.post),
                            transition: Transition.fadeIn);
                      },
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 14)),
                        backgroundColor:
                            WidgetStatePropertyAll(AppTheme.bgColor),
                        elevation: WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                      ),
                      child: const Text(
                        textAlign: TextAlign.center,
                        "Detail",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.primary),
                      ),
                    ),
                  )
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
