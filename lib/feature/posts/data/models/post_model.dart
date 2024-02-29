// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_course/feature/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required int id,
    required String title,
    required String body,
  }) : super(
          id: id,
          title: title,
          body: body,
        );
  @override
  PostModel copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: int.parse(map['id'].toString()),
      title: map['title'].toString(),
      body: map['body'].toString(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title, body];
}
