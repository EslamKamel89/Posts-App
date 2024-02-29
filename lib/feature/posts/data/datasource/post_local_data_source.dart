import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cacheAllPosts(List<PostModel> postModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class LocalDataSourceImp implements LocalDataSource {
  SharedPreferences sharedPreferences;
  LocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cacheAllPosts(List<PostModel> postModels) async {
    await sharedPreferences.setString(
      CACHED_POSTS,
      jsonEncode(postModels.map<Map<String, dynamic>>((e) => e.toJson()).toList()),
    );
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final String? jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      final List<PostModel> postModels = (jsonDecode(jsonString) as List).map((e) => PostModel.fromJson(e)).toList();
      return Future.value(postModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
