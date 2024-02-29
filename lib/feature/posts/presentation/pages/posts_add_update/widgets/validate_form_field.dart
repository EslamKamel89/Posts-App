import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';

validateFormField({
  required GlobalKey<FormState> formKey,
  required PostEntity? post,
  required BuildContext context,
  required TextEditingController titleController,
  required TextEditingController contentController,
}) {
  if (formKey.currentState!.validate()) {
    final title = titleController.text;
    final body = contentController.text;
    if (post != null) {
      context.read<AddDeleteUpdatePostBloc>().add(
            UpdatePostEvent(
              postEntity: PostEntity(id: 0, title: title, body: body),
            ),
          );
    } else {
      context.read<AddDeleteUpdatePostBloc>().add(
            AddPostEvent(
              postEntity: PostEntity(id: 0, title: title, body: body),
            ),
          );
    }
  }
}
