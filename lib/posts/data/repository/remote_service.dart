import 'package:dio/dio.dart';

import '../models/post.dart';
part 'dio_service.dart';

abstract class RemoteService {
  const RemoteService(this.dio);
  final Dio dio;

  Future<List<Post>?> postFetched([int startIndex = 0]);
}
