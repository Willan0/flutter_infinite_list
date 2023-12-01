import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_bloc/posts/bloc/post_bloc.dart';
import 'package:infinite_list_bloc/posts/data/repository/remote_service.dart';
import 'package:infinite_list_bloc/posts/widgets/post_list_view.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinite List bloc",),
      ),
      body: BlocProvider(
        create: (__)=> PostBloc(remoteService: DioService(Dio()))..add(PostFetchedEvent()),
          child: const PostListView()),
    );
  }
}
