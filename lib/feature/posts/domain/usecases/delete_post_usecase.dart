import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/extension.dart';
import '../repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;
  DeletePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(int postId) async {
    final t = 'DeletePostUseCase - call '.prt;
    return (await repository.deletePost(postId)).prm(t);
  }
}
