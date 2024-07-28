import 'dart:convert';
import 'package:ban_hang/models/product_model.dart';
import 'http_service.dart';

class ProductApi {
  final httpService = HttpService();

  Future<List<ProductModel>> getProducts(int page) async {
    const int limit = 4;
    page = page ?? 1;
    final response = await httpService.get("products?page=$page&limit=$limit");
    final products = jsonDecode(response.body)['content'];
    return products
        .map<ProductModel>((product) => ProductModel.fromJson(product))
        .toList();
  }

  Future<ProductModel> getProduct(int productId) async {
    final response = await httpService.get("products/$productId");
    final product = jsonDecode(response.body);
    return ProductModel.fromJson(product);
  }
}
