// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class LoadingPostState extends PostState {}

class LoadedPostState extends PostState {
  final List<PostEntity> posts;
  const LoadedPostState({required this.posts});
  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'LoadedState(posts: $posts)';
}

class ErrorPostState extends PostState {
  final String errorMessage;
  const ErrorPostState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'ErrorState(errorMessage: $errorMessage)';
}
