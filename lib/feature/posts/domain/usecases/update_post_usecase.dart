import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extension.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;
  UpdatePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(PostEntity postEntity) async {
    final t = 'UpdatePostUseCase - call '.prt;
    return (await repository.updatePost(postEntity)).prm(t);
  }
}
