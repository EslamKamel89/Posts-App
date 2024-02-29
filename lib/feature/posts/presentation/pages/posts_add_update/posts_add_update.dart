import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/snackbar.dart';
import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../domain/entities/post_entity.dart';
import '../../bloc/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../posts_page/posts_page.dart';
import 'widgets/add_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/validate_form_field.dart';

class PostAddOrUpdatePage extends StatefulWidget {
  const PostAddOrUpdatePage({
    super.key,
    required this.title,
    required this.addButtonText,
    this.post,
  });
  final String title;
  final String addButtonText;
  final PostEntity? post;

  @override
  State<PostAddOrUpdatePage> createState() => _PostAddOrUpdatePageState();
}

class _PostAddOrUpdatePageState extends State<PostAddOrUpdatePage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  void initState() {
    if (widget.post != null) {
      titleController.text = widget.post!.title;
      contentController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar.def(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: _mapStateToMessage,
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingProgressWidget();
            }
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(width: double.infinity, height: 50),
                  CustomTextField(
                    title: 'title',
                    controller: titleController,
                    validator: (title) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    title: 'content',
                    numberOfLines: 10,
                    controller: contentController,
                    validator: (content) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AddButton(
                    addButtonText: widget.addButtonText,
                    onTap: () {
                      validateFormField(
                        context: context,
                        formKey: formKey,
                        post: widget.post,
                        titleController: titleController,
                        contentController: contentController,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _mapStateToMessage(
    BuildContext context,
    AddDeleteUpdatePostState state,
  ) {
    if (state is AddDeleteUpdatePostInitial) {
    } else if (state is LoadingAddDeleteUpdatePostState) {
    } else if (state is ErrorAddDeleteUpdatePostState) {
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
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const PostsPage()), (route) => false);
    }
  }
}
