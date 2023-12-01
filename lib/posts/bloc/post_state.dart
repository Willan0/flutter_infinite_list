part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const <Post>[],
      this.isReachedMax = false});

  final PostStatus status;
  final List<Post> posts;
  final bool isReachedMax;

  PostState copyWith(
      {PostStatus? status, List<Post>? posts, bool? isReachedMax}) {
    return PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        isReachedMax: isReachedMax ?? this.isReachedMax);
  }

  @override
  List<Object?> get props => [status, posts, isReachedMax];
}
