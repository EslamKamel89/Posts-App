// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  const PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [id, title, body];

  PostEntity copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  bool get stringify => true;
}
