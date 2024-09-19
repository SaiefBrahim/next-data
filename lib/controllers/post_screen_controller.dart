import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:next_data_saief_brahim/helpers/app_constants.dart';
import 'package:next_data_saief_brahim/helpers/info_controller.dart';
import 'package:next_data_saief_brahim/models/post.dart';
import 'package:next_data_saief_brahim/models/post_author.dart';

class PostsScreenController extends GetxController {
  final Connectivity connectivity = Connectivity();
  RxBool isLoading = false.obs;
  List<Post> postsList = [];
  List<PostAuthor> usersList = [];

  @override
  void onInit() {
    super.onInit();
  }

  fetchData() async {

    var hasInternet =
    await connectivity.checkConnectivity();
    if (hasInternet[0] != ConnectivityResult.none) {
      await getPosts();
      await getUsers();
    } else {
      return;
    }
  }

  getPosts() async {
    try {
      Uri url = Uri.parse(AppConstants.postsApi);
      var response = await http.get(url);
      if (response.statusCode != 200) {
        Info.message('Something went wrong, Error ${response.statusCode}',
            context: Get.context!, duration: const Duration(seconds: 4));
        return;
      }
      List<dynamic> postsListTemp =
          json.decode(utf8.decode(response.bodyBytes));
      postsList = postsListTemp.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('getPosts Error $e');
      }
      return;
    }
  }

  getUsers() async {
    try {
      Uri url = Uri.parse(AppConstants.userApi);
      var response = await http.get(url);
      if (response.statusCode != 200) {
        Info.message('Something went wrong, Error ${response.statusCode}',
            context: Get.context!, duration: const Duration(seconds: 4));
        return;
      }
      List<dynamic> usersListTemp =
          json.decode(utf8.decode(response.bodyBytes));
      usersList = usersListTemp.map((e) => PostAuthor.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('getUsers Error $e');
      }
      return;
    }
  }
}
