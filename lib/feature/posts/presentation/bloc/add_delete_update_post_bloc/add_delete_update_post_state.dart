part of 'add_delete_update_post_bloc.dart';

sealed class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String errorMsg;
  const ErrorAddDeleteUpdatePostState({required this.errorMsg});
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;
  const MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}
