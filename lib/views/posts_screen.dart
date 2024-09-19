import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/controllers/post_screen_controller.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';
import 'package:next_data_saief_brahim/models/post.dart';
import 'package:next_data_saief_brahim/models/post_author.dart';
import 'package:next_data_saief_brahim/views/components/post_card.dart';
import 'package:next_data_saief_brahim/views/post_details.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  PostsScreenState createState() => PostsScreenState();
}

class PostsScreenState extends State<PostsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Post> searchSuggestions = [];
  PostsScreenController postsScreenController =
      Get.find<PostsScreenController>();
  final Connectivity connectivity = Connectivity();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  searchPosts(String query) async {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      searchSuggestions = postsScreenController.postsList
          .where((post) =>
              post.title.toString().toLowerCase().contains(lowerCaseQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 108,
        backgroundColor: AppTheme.light,
        elevation: 0,
        flexibleSpace: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu_open_sharp,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text("Browse posts",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                      searchSuggestions.clear();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppTheme.base,
                                    size: 24,
                                  ),
                                )
                              : null,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppTheme.base,
                            size: 26,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(28),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(28),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          labelText: 'Search ...',
                          labelStyle: const TextStyle(
                              fontSize: 14, color: AppTheme.base),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                        onChanged: (value) {
                          searchPosts(searchController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.bgColor,
      body: Stack(
        children: [
          // Main body content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildPostCards(),
                ],
              ),
            ),
          ),

          // Floating search suggestions
          if (searchController.text.isNotEmpty)
            Positioned(
              top: 0, // Adjust the top position based on your AppBar height
              left: 0,
              right: 0,
              child: Material(
                color: AppTheme.light,
                elevation: 1, // Adds shadow to the suggestions list
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: searchSuggestions.isEmpty ? 100 : 300,
                  // Adjust the height for the floating suggestions
                  child: _buildSearchSuggestions(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPostCards() {
    if (postsScreenController.postsList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Card(

            color: AppTheme.light,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
              child: SvgPicture.asset(
                AppImages.serverError,
                height: 120,
              ),
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: postsScreenController.postsList.length,
      itemBuilder: (context, index) {
        Post item = postsScreenController.postsList[index];
        PostAuthor? user = postsScreenController.usersList
            .firstWhereOrNull((e) => e.id == item.id);
        return PostCard(height: 120, user: user?.name, post: item);
      },
    );
  }

  Widget _buildSearchSuggestions() {
    if (searchSuggestions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No results found',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: searchSuggestions.length > 16 ? 16 : searchSuggestions.length,
      itemBuilder: (context, index) {
        Post item = searchSuggestions[index];
        return ListTile(
            title: Text(item.title ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 14, color: Colors.black)),
            onTap: () async {
              setState(() {
                searchController.clear();
                searchSuggestions.clear();
              });
              Get.to(() => PostsDetails(post: item),
                  transition: Transition.fadeIn);
            });
      },
    );
  }
}
