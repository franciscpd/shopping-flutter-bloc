import 'package:dio/dio.dart';
import '../models/category.model.dart';
import '../settings.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getAll() async {
    var url = "${Settings.baseUrl}v1/categories";
    Response response = await Dio().get(url);

    return (response.data as List)
      .map((category) => CategoryModel.fromJson(category))
      .toList();
  }
}
