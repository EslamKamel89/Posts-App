import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/extension.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasource/post_local_data_source.dart';
import '../datasource/post_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImp extends PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final t = ' PostRepositoryImp - getAllPosts'.prt;
    if (await networkInfo.isInternetConnected) {
      try {
        final List<PostModel> postModels = await remoteDataSource.getAllPosts();
        await localDataSource.cacheAllPosts(postModels);
        postModels.prm(t + 'from remote data source');
        return right(postModels);
      } on ServerException {
        'ServerException'.prm(t);
        return left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> postModels = await localDataSource.getCachedPosts();
        postModels.prm(t + 'from local data source');
        return right(postModels);
      } on EmptyCacheException {
        'EmptyCacheException'.prm(t);
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity postEntity) async {
    final t = ' PostRepositoryImp - addPost '.prt;
    final PostModel postModel = PostModel(
      id: postEntity.id,
      title: postEntity.title,
      body: postEntity.body,
    );
    final successOrFailure = _errorHandler(
      () async {
        return remoteDataSource.addPost(postModel);
      },
    );
    successOrFailure.then((value) => value.prm(t));
    return successOrFailure;
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    final t = ' PostRepositoryImp - deletePost'.prt;
    final successOrFailure = _errorHandler(
      () async {
        return remoteDataSource.deletePost(postId);
      },
    );
    successOrFailure.then((value) => value.prm(t));
    return successOrFailure;
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity postEntity) async {
    final t = ' PostRepositoryImp - updatePost '.prt;
    final PostModel postModel = PostModel(
      id: postEntity.id,
      title: postEntity.title,
      body: postEntity.body,
    );
    final successOrFailure = _errorHandler(
      () async {
        return remoteDataSource.updatePost(postModel);
      },
    );
    successOrFailure.then((value) => value.prm(t));
    return successOrFailure;
  }

  Future<Either<Failure, Unit>> _errorHandler(Function func) async {
    final t = ' PostRepositoryImp - _errorHandler '.prt;
    if (await networkInfo.isInternetConnected) {
      'networkInfo.isInternetConnected == true'.prm(t);
      try {
        await func();
        return right(unit);
      } on ServerException {
        'ServerException'.prm(t);
        return left(ServerFailure());
      }
    } else {
      'networkInfo.isInternetConnected == false'.prm(t);
      try {
        throw OfflineException();
      } on OfflineException {
        'OfflineFailure'.prm(t);
        return left(OfflineFailure());
      }
    }
  }
}
