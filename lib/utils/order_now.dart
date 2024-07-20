// import 'package:ban_hang/utils/show_notification.dart';
// import 'package:flutter/cupertino.dart';
// import '../cubit/cart_cubit.dart';
// import '../models/cart_product_model.dart';
//
// Future<void> orderNow(CartCubit cartCubit, CartProductModel product, BuildContext context) async {
//   final cartProduct = CartProductModel(
//       id: product.id,
//       name: product.name,
//       unitPrice: product. unitPrice,
//       quantity: 1,
//       price: product.price);
//   try {
//     await cartCubit.addProductIntoCart(cartProduct);
//     showNotification(context, "Add product into cart is success");
//   } catch (e) {
//     showNotification(context, "Add product into cart is failure");
//   }
// }