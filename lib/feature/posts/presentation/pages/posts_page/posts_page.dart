import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/appbar.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../domain/entities/post_entity.dart';
import '../../bloc/post_bloc/post_bloc.dart';
import '../posts_add_update/posts_add_update.dart';
import 'widgets/error_view.dart';
import 'widgets/loaded_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.def(title: 'Posts'),
      floatingActionButton: _buildFloatingBtn(context: context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return _handlingDataView(
              state: state,
              loadedWidget: Builder(builder: (context) {
                LoadedPostState loadedPostState = state as LoadedPostState;
                return RefreshIndicator(
                  onRefresh: () async {
                    _onRefresh(context: context);
                  },
                  child: LoadedWidget(posts: loadedPostState.posts),
                );
                // return LoadedWidget(posts: testPosts);
              }),
            );
          },
        ),
      ),
    );
  }

  _onRefresh({required BuildContext context}) {
    context.read<PostBloc>().add(RefreshPostsEvent());
  }

  FloatingActionButton _buildFloatingBtn({required BuildContext context}) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PostAddOrUpdatePage(
              title: 'Add new Post',
              addButtonText: 'Add',
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _handlingDataView({required PostState state, required Widget loadedWidget}) {
    if (state is PostInitial) {
      return const Center(child: Text('Post Initial State'));
    } else if (state is LoadingPostState) {
      return const LoadingProgressWidget();
    } else if (state is ErrorPostState) {
      return MyErrorWidget(errorMessage: state.errorMessage);
    } else if (state is LoadedPostState) {
      return loadedWidget;
    } else {
      return const SizedBox();
    }
  }
}

List<PostEntity> testPosts = [
  const PostEntity(
      id: 1,
      title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      body:
          "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
  const PostEntity(
      id: 2,
      title: "qui est esse",
      body:
          "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"),
  const PostEntity(
      id: 3,
      title: "ea molestias quasi exercitationem repellat qui ipsa sit aut",
      body:
          "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"),
  const PostEntity(
      id: 4,
      title: "eum et est occaecati",
      body:
          "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"),
  const PostEntity(
      id: 5,
      title: "nesciunt quas odio",
      body:
          "repudiandae veniam quaerat sunt sed\nalias aut fugiat sit autem sed est\nvoluptatem omnis possimus esse voluptatibus quis\nest aut tenetur dolor neque"),
];
