import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/extension.dart';
import '../models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

const String BASE_URL = "https://jsonplaceholder.typicode.com/";

class RemoteDataSourceImp implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final t = 'getAllPosts - RemoteDataImp '.prt;
    final response = await client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      'response.statusCode == 200'.prm(t);
      List jsonList = jsonDecode(response.body);
      List<PostModel> postModels = jsonList.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(postModels.prm(t));
    } else {
      'response.statusCode != 200'.prm(t);
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final t = 'addPost - RemoteDataImp'.prt;
    final body = {'title': postModel.title, 'body': postModel.body};
    final response = await client.post(
      Uri.parse('$BASE_URL/posts/'),
      body: body,
      // headers: {'Content-Type': 'application/json'},
    );
    response.statusCode.prm(t);
    if (response.statusCode == 200 || response.statusCode == 201) {
      'response.statusCode == 200'.prm(t);
      return Future.value(unit);
    } else {
      'response.statusCode != 200'.prm(t);
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final t = 'deletePost - RemoteDataImp '.prt;
    final response = await client.delete(
      Uri.parse('$BASE_URL/posts/$postId'),
      body: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      'response.statusCode == 200'.prm(t);
      return Future.value(unit);
    } else {
      'response.statusCode != 200'.prm(t);
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final t = 'updatePost - RemoteDataImp'.prt;
    final postId = postModel.id.toString();
    final data = {'title': postModel.title, 'body': postModel.body};
    final response = await client.patch(
      Uri.parse('$BASE_URL/posts/$postId'),
      // headers: {'Content-Type': 'application/json'},
      body: data,
    );
    if (response.statusCode == 200) {
      'response.statusCode == 200'.prm(t);
      return Future.value(unit);
    } else {
      'response.statusCode != 200'.prm(t);
      throw ServerException();
    }
  }
}
