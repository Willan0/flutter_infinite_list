part of 'remote_service.dart';

class DioService extends RemoteService {
  const DioService(super.dio);

  final int _postLimit = 20;
  final kBaseUrl = 'https://jsonplaceholder.typicode.com';
  final kEndPointPost = '/posts';
  @override
  Future<List<Post>?> postFetched([int startIndex = 0]) async {
    try {
      var response = await dio
          .get('$kBaseUrl$kEndPointPost',queryParameters:<String,dynamic>{
            "_start" : startIndex,
            "_limit" : _postLimit
      });
      if (response.statusCode == 200) {
        final posts = (response.data as List)
            .map((e) => Post(id: e['id'], title: e['title'], body: e['body']))
            .toList();
        return posts;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("post fetched error { $e }");
    }
  }
}
