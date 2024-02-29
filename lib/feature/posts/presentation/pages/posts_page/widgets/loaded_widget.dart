import 'package:flutter/material.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../post_details/post_details.dart';

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({
    super.key,
    required this.posts,
  });
  final List<PostEntity> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        PostEntity post = posts[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailsPage(
                  post: post,
                ),
              ),
            );
          },
          title: Text(
            post.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              post.id.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          subtitle: Text(post.body),
        );
      },
    );
  }
}
