import 'dart:convert';
import 'package:ban_hang/api/user_api.dart';
import 'package:ban_hang/utils/constant.dart';
import '../models/cart_product_model.dart';
import '../models/order_product_model.dart';
import '../utils/local_storage.dart';
import 'http_service.dart';

class OrderApi {
  static const int paymentMethod = 2;
  static const int orderStatus = 1;

  final httpService = HttpService();

  Future<dynamic> addOrder(List<CartProductModel> products, int total) async {
    final token = await LocalStorage.getValue(Constants.token);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    List<OrderProductModel> orderProducts = products.map((product) {
      return OrderProductModel(
          productId: product.id,
          quantity: product.quantity,
          unitPrice: product.unitPrice);
    }).toList();
    final body = {
      'total': total,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'details': orderProducts
    };
    final jsonBody = json.encode(body);
    return await httpService.post("orders", body: jsonBody, headers: headers);
  }
}
