import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extension.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class AddPostUseCase {
  final PostRepository repository;
  AddPostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(PostEntity postEntity) async {
    final t = 'AddPostUseCase - call '.prt;
    return (await repository.addPost(postEntity)).prm(t);
  }
}
