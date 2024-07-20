import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_product_model.dart';
import '../utils/constant.dart';
import '../utils/local_storage.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartProductModel> cartProducts = [];

  CartCubit() : super(const CartState([])) {
    loadCartFromLocalStorage();
  }

  loadCartFromLocalStorage() async {
    final cartJson = await LocalStorage.getValue(Constants.cart);
    if (cartJson != null) {
      final List<dynamic> decodedJson = jsonDecode(cartJson);
      final cartProductsLocal =
          decodedJson.map((e) => CartProductModel.fromJson(e)).toList();
      cartProducts = cartProductsLocal;
      emit(CartState(cartProducts));
    }
  }

  addProductIntoCart(CartProductModel product) async {
      int index = cartProducts
          .indexWhere((cartProduct) => cartProduct.id == product.id);
      if (index != -1) {
        cartProducts[index].quantity += 1;
        cartProducts[index].price = cartProducts[index].unitPrice * cartProducts[index].quantity;
      } else {
        cartProducts.add(product);
      }
      List<Map<String, dynamic>> jsonList = cartProducts.map((product) => product.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      await LocalStorage.setValue(Constants.cart, jsonString);
      emit(CartState(cartProducts));
  }

  deleteAProductInCart(int productId) async {
      cartProducts.removeWhere((product) => product.id == productId);
      List<Map<String, dynamic>> jsonList = cartProducts.map((product) => product.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      await LocalStorage.setValue(Constants.cart, jsonString);
      emit(CartState(cartProducts));
  }

  clearCart() async {
    cartProducts = [];
    await LocalStorage.deleteValue(Constants.cart);
    emit(CartState(cartProducts));
  }

  List<CartProductModel> get cartProductsList => cartProducts;
}
