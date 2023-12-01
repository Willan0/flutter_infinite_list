import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_bloc/posts/bloc/post_bloc.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status == PostStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PostStatus.failure) {
          return const Center(
            child: Text("Something went wrong! "),
          );
        }
        if (state.posts.isEmpty) {
          return const Center(
            child: Text("There is no post "),
          );
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount:
              state.isReachedMax ? state.posts.length : state.posts.length + 1,
          itemBuilder: (context, index) {
            return index >= (state.posts.length)
                ? const BottomLoader()
                : PostCard(
                    id: state.posts[index].id,
                    title: state.posts[index].title,
                    body: state.posts[index].body);
          },
        );
      },
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}

class PostCard extends StatelessWidget {
  const PostCard(
      {super.key, required this.title, required this.body, required this.id});

  final int id;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Text(id.toString()),
        title: Text(
          title,
        ),
        subtitle: Text(body),
        isThreeLine: true,
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
