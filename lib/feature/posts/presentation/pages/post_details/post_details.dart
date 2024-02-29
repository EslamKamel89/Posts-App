import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/snackbar.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../domain/entities/post_entity.dart';
import '../../bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../posts_add_update/posts_add_update.dart';
import '../posts_page/posts_page.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.def(title: 'Post Details'),
      body: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
        listener: _postDetailsListener,
        builder: (context, state) {
          if (state is LoadingAddDeleteUpdatePostState) {
            return const LoadingProgressWidget();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              children: [
                ...postDetailsWidget(post: post),
                const SizedBox(height: 30),
                EditAndDeleteBtn(post: post),
              ],
            ),
          );
        },
      ),
    );
  }

  void _postDetailsListener(BuildContext context, AddDeleteUpdatePostState state) {
    if (state is ErrorAddDeleteUpdatePostState) {
      customSnackBar(
        context: context,
        title: state.errorMsg,
        backgroundColor: Colors.red,
      );
    } else if (state is MessageAddDeleteUpdatePostState) {
      customSnackBar(
        context: context,
        title: state.message,
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const PostsPage()),
        (route) => false,
      );
    }
  }
}

List<Widget> postDetailsWidget({required PostEntity post}) {
  return [
    Text(
      post.title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    const Divider(height: 50),
    Text(
      post.body,
      style: const TextStyle(fontSize: 15),
    ),
  ];
}

class EditAndDeleteBtn extends StatelessWidget {
  const EditAndDeleteBtn({
    super.key,
    required this.post,
  });
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostAddOrUpdatePage(
                  title: 'Update',
                  addButtonText: 'Save',
                  post: post,
                ),
              ),
            );
          },
          child: _btnContainer(title: 'Edit', backgroundColor: Colors.blue),
        ),
        InkWell(
            onTap: () async {
              await customAlertDialogue(
                context: context,
                msg: 'Are you sure you want to delete this post',
                actionOne: TextButton(
                  onPressed: () {
                    context.read<AddDeleteUpdatePostBloc>().add(DeletePostEvent(postId: post.id));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
              );
            },
            child: _btnContainer(title: 'Delete', backgroundColor: Colors.red)),
      ],
    );
  }

  Container _btnContainer({
    required String title,
    required Color backgroundColor,
  }) {
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(color: backgroundColor),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

Future customAlertDialogue({
  required BuildContext context,
  String? title,
  required String msg,
  String? popText,
  Icon? titleIcon,
  Widget? actionOne,
  Widget? actionTwo,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleIcon ?? const Icon(Icons.warning, size: 20),
            const SizedBox(width: 10),
            Text(title ?? 'Info'),
          ],
        ),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        content: Text(msg, textAlign: TextAlign.center),
        contentPadding: const EdgeInsets.only(bottom: 12, top: 12),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(popText ?? 'Back'),
          ),
          actionOne ?? const SizedBox(width: 0, height: 0),
          actionTwo ?? const SizedBox(width: 0, height: 0),
        ],
        actionsAlignment: MainAxisAlignment.end,
      );
    },
  );
}
