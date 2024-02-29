import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/extension.dart';
import '../../../../../core/strings/failure.dart';
import '../../../../../core/strings/message.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/add_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  // ----------------------------------------
  AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddPostEvent>(_addPostEvent);
    on<DeletePostEvent>(_deletePostEvent);
    on<UpdatePostEvent>(_updatePostEvent);
  }
  // ----------------------------------------
  _addPostEvent(
    AddPostEvent event,
    Emitter<AddDeleteUpdatePostState> emit,
  ) async {
    final t = '_addPostEvent - AddDeleteUpdatePostBloc'.prt;
    emit(LoadingAddDeleteUpdatePostState());
    final addOrError = await addPostUseCase(event.postEntity);
    emit(_handlingErrorOrSuccess(addOrError, AppMessages.ADD_SUCCESS).prm(t));
  }

  // ----------------------------------------
  _deletePostEvent(
    DeletePostEvent event,
    Emitter<AddDeleteUpdatePostState> emit,
  ) async {
    final t = '_deletePostEvent - AddDeleteUpdatePostBloc'.prt;
    emit(LoadingAddDeleteUpdatePostState());
    final deleteOrError = await deletePostUseCase(event.postId);
    emit(_handlingErrorOrSuccess(deleteOrError, AppMessages.DELETE_SUCCESS).prm(t));
  }

  // ----------------------------------------
  _updatePostEvent(
    UpdatePostEvent event,
    Emitter<AddDeleteUpdatePostState> emit,
  ) async {
    final t = '_updatePostEvent - AddDeleteUpdatePostBloc'.prt;
    emit(LoadingAddDeleteUpdatePostState());
    final updateOrError = await updatePostUseCase(event.postEntity);
    emit(_handlingErrorOrSuccess(updateOrError, AppMessages.UPDATE_SUCCESS).prm(t));
  }

  // ----------------------------------------
  String _mapFailureToMessage(Failure failure) {
    final t = '_mapFailureToMessage - AddDeleteUpdatePostBloc'.prt;
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

  // ----------------------------------------
  AddDeleteUpdatePostState _handlingErrorOrSuccess(
    Either<Failure, Unit> successOrError,
    String successMessage,
  ) {
    return successOrError.fold(
      (failure) {
        return ErrorAddDeleteUpdatePostState(errorMsg: _mapFailureToMessage(failure));
      },
      (_) {
        return MessageAddDeleteUpdatePostState(message: successMessage);
      },
    );
  }
}
