import 'package:dio/dio.dart';
import 'package:flutter_todo_app/feature/home/model.dart';

final dio = Dio();

class Api {
  static Future<List<ProductModel>?> getPost(int page, int limit) async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products',
        queryParameters: {
          'limit': limit,
          'page': page * limit,
          'select': 'title,id,price,thumbnail',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> myBody = response.data['products'];
        final List<ProductModel> posts = myBody
            .map((item) => ProductModel.fromMap(item))
            .toList();
        return posts;
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
