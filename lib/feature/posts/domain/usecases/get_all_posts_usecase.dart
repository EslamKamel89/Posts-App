import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extension.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository repository;
  GetAllPostsUseCase({required this.repository});
  Future<Either<Failure, List<PostEntity>>> call() async {
    final t = 'GetAllPostsUseCase - call '.prt;
    return (await repository.getAllPosts()).prm(t);
  }
}
