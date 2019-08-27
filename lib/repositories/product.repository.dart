import 'package:dio/dio.dart';
import '../settings.dart';
import '../models/product.model.dart';
import '../models/product-list.model.dart';

class ProductRepository {
  Future<List<ProductListModel>> getAll() async {
    var url = "${Settings.baseUrl}v1/products";
    Response response = await Dio().get(url);

    return (response.data as List)
      .map((product) => ProductListModel.fromJson(product))
      .toList();
  }

  Future<List<ProductListModel>> getByCategory(String category) async {
    var url = "${Settings.baseUrl}v1/categories/$category/products";
    Response response = await Dio().get(url);

    return (response.data as List)
      .map((product) => ProductListModel.fromJson(product))
      .toList();
  }

  Future<ProductModel> get(String tag) async {
    var url = "${Settings.baseUrl}v1/products/$tag";
    Response response = await Dio().get(url);

    return ProductModel.fromJson(response.data);
  }
}
