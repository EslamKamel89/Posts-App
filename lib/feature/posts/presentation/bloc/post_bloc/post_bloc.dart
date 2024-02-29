import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extension.dart';
import '../../../../../core/strings/failure.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/get_all_posts_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostBloc({required this.getAllPostsUseCase}) : super(PostInitial()) {
    on<GetAllPostsEvent>(_getAllPostsEvent);
    on<RefreshPostsEvent>(_refershPostsEvent);
  }
  _getAllPostsEvent(GetAllPostsEvent event, Emitter<PostState> emit) async {
    final t = '_getAllPostsEvent - PostBloc'.prt;
    emit(LoadingPostState());
    final postsOrFailure = await getAllPostsUseCase();
    postsOrFailure.prm(t);
    postsOrFailure.fold(
      (failure) {
        failure.runtimeType.toString().prm(t + '  left fold');
        emit(ErrorPostState(errorMessage: _mapFailureToMessage(failure)));
      },
      (posts) {
        posts.prm(t + '  right fold');
        emit(LoadedPostState(posts: posts));
      },
    );
  }

  _refershPostsEvent(RefreshPostsEvent event, Emitter<PostState> emit) async {
    final t = '_refershPostsEvent - PostBloc'.prt;
    emit(LoadingPostState());
    final postsOrFailure = await getAllPostsUseCase();
    postsOrFailure.prm(t);
    postsOrFailure.fold(
      (failure) {
        failure.runtimeType.toString().prm(t + '  left fold');
        emit(ErrorPostState(errorMessage: _mapFailureToMessage(failure)));
      },
      (posts) {
        posts.prm(t + '  right fold');
        emit(LoadedPostState(posts: posts));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    final t = '_mapFailureToMessage - PostBloc'.prt;
    switch (failure.runtimeType) {
      case OfflineFailure:
        return AppFailure.offlineFailure.prm(t);
      case ServerFailure:
        return AppFailure.serverFailure.prm(t);
      case EmptyCacheFailure:
        return AppFailure.emptyCacheFailure.prm(t);
      default:
        return AppFailure.unexpectedErrorFailure.prm(t);
    }
  }
}
