import 'package:flutter/material.dart';
import 'package:ban_hang/widgets/button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';
import '../models/cart_product_model.dart';
import '../screens/product_detail.dart';
import '../utils/show_notification.dart';

class Product extends StatelessWidget {

  const Product(
      {super.key,
      required this.productId,
      required this.urlImage,
      required this.productName,
      required this.productPrice,
      required this.productStock});

  final int productId;
  final String urlImage;
  final String productName;
  final int productPrice;
  final int productStock;

  @override
  Widget build(BuildContext context) {
    return _Product(
      productId: productId,
      urlImage: urlImage,
      productName: productName,
      productPrice: productPrice,
      productStock: productStock,

    );
  }
}

class _Product extends StatefulWidget {

  const _Product(
      {super.key,
      required this.productId,
      required this.urlImage,
      required this.productName,
      required this.productPrice,
      required this.productStock});

  final int productId;
  final String urlImage;
  final String productName;
  final int productPrice;
  final int productStock;

  @override
  State<_Product> createState() => ProductWidget();
}

class ProductWidget extends State<_Product> {

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Màu border
            width: 1.0, // Độ rộng border
          ),
          borderRadius: BorderRadius.circular(5.0), // Bán kính các góc
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 17),
                child: Image.network(
                  widget.urlImage,
                  width: 183,
                  height: 243,
                ),
              ),
              Text(
                widget.productName,
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text("\$${widget.productPrice}",
                  style: const TextStyle(fontSize: 16)),
              Text("${widget.productStock} units in stock",
                  style: const TextStyle(fontSize: 16)),
              Row(
                children: [
                  Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                                icon: "images/icons/infor.svg",
                                text: "Detail",
                                fontSizeButton: 16,
                                color: Colors.white,
                                backGroundColor: const Color(0xFF428BCA),
                                handleOnPressed: () => redirectDetail(context)),
                          ),
                          const SizedBox(width: 4.46),
                          Expanded(
                              child: ButtonWidget(
                                icon: "images/icons/cart.svg",
                                text: "Order Now",
                                fontSizeButton: 16,
                                color: Colors.white,
                                backGroundColor: const Color(0xFFF0AD4E),
                                handleOnPressed: () => {
                                  orderNow(cartCubit)
                                },
                              ))
                        ],
                      ))
                ],
              )
            ],
          ),
        )
    );
  }

  void redirectDetail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProductDeatilPage(),
            settings: RouteSettings(arguments: widget.productId)));
  }

  Future<void> orderNow(CartCubit cartCubit) async {
    final cartProduct = CartProductModel(
        id: widget.productId,
        name: widget.productName,
        unitPrice: widget.productPrice,
        quantity: 1,
        price: widget.productPrice);
    try {
      await cartCubit.addProductIntoCart(cartProduct);
      if(!mounted) return;
      showNotification(context, "Add product into cart is success");
    } catch (e) {
      if(!mounted) return;
      showNotification(context, "Add product into cart is failure");
    }
  }
}


