import 'package:dio/dio.dart';
import 'package:flutter_todo_app/feature/home/model.dart';

final dio = Dio();

class Api {
  static Future<List<PostModel>?> getPost(int page, int limit) async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
        queryParameters: {'_page': page, '_limit': limit},
      );

      if (response.statusCode == 200) {
        final List<dynamic> myBody = response.data;
        final List<PostModel> posts = myBody
            .map((item) => PostModel.fromMap(item))
            .toList();
        return posts;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
