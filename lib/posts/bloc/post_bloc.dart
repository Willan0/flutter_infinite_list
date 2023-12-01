import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list_bloc/posts/data/repository/remote_service.dart';
import 'package:stream_transform/stream_transform.dart';

import '../data/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.remoteService}) : super(const PostState()) {
    on<PostFetchedEvent>(_onPostFetchedEvent,
        transformer: throttleDroppable(throttleDuration));
  }
  final RemoteService remoteService;

  Future<void> _onPostFetchedEvent(
      PostFetchedEvent event, Emitter<PostState> emit) async {
    if (state.isReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await remoteService.postFetched();
        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, isReachedMax: false));
      }
      final posts = await remoteService.postFetched(state.posts.length);
      emit((posts?.isEmpty ?? false)
          ? state.copyWith(isReachedMax: true)
          : state.copyWith(
              status: PostStatus.success, posts: List.of(state.posts)..addAll(posts ?? []), isReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
