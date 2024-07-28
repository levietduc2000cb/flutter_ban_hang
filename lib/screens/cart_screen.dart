import 'package:ban_hang/cubit/cart_state.dart';
import 'package:ban_hang/screens/login_screen.dart';
import 'package:ban_hang/screens/home_screen.dart';
import 'package:ban_hang/widgets/button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../api/order_api.dart';
import '../cubit/cart_cubit.dart';
import '../models/cart_product_model.dart';
import '../utils/constant.dart';
import '../utils/local_storage.dart';
import '../utils/show_alert_widget.dart';
import '../utils/show_notification.dart';
import '../widgets/column_title_table_widget.dart';
import '../widgets/main_navigation_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CartCubit(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(96),
            child: AppBar(
                flexibleSpace: Container(
              decoration: const BoxDecoration(
                color:
                    Color.fromRGBO(238, 238, 238, 1), // Đặt màu nền cho AppBar
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text("Cart",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("All products selected are in your cart",
                            style: TextStyle(fontSize: 16))
                      ],
                    ))
                  ],
                ),
              ),
            )),
          ),
          bottomNavigationBar: const MainNavigation(pageName: "Cart"),
          body: const CartDetail(),
        ),
      ),
    );
  }
}

class CartDetail extends StatefulWidget {
  const CartDetail({super.key});

  @override
  State<CartDetail> createState() => _CartDetail();
}

class _CartDetail extends State<CartDetail> {
  bool isLoading = false;
  final orderApi = OrderApi();

  TableRow buildTableRow(int productId, String productName, dynamic quantity,
      dynamic unitPrice, dynamic price, Function()? handleDelete) {
    quantity = quantity.toString();
    unitPrice = unitPrice.toString();
    price = price.toString();
    return TableRow(children: [
      GestureDetector(
        onTap: handleDelete,
        child: Container(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SvgPicture.asset("images/icons/delete_cart_item.svg")],
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          child: Text(productName, style: const TextStyle(fontSize: 14))),
      Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(quantity, style: const TextStyle(fontSize: 14))),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          child: Text("\$$unitPrice", style: const TextStyle(fontSize: 14))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          child: Text("\$$price", style: const TextStyle(fontSize: 14)))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              List<CartProductModel> products = state.cartProducts;
              int total =
                  products.fold(0, (sum, product) => sum + product.price);
              return Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Column(children: [
                    Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.1),
                        1: FractionColumnWidth(0.4),
                        2: FractionColumnWidth(0.12),
                        3: FractionColumnWidth(0.23),
                        4: FractionColumnWidth(0.15)
                      },
                      border: const TableBorder(
                          horizontalInside:
                              BorderSide(width: 1, color: Colors.grey)),
                      children: [
                        // Title
                        TableRow(children: [
                          Container(
                            color: const Color.fromRGBO(249, 249, 249, 1),
                            child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 9),
                                child: Text("")),
                          ),
                          const ColumnTitleTable(title: "Product"),
                          const ColumnTitleTable(title: "Qty"),
                          const ColumnTitleTable(title: "Unit Price"),
                          const ColumnTitleTable(title: "Price")
                        ]),
                        // Items
                        for (int index = 0; index < products.length; index++)
                          buildTableRow(
                              products[index].id,
                              products[index].name,
                              products[index].quantity,
                              products[index].unitPrice,
                              products[index].price,
                              () => {
                                    context
                                        .read<CartCubit>()
                                        .deleteAProductInCart(
                                            products[index].id)
                                  }),
                      ],
                    ),
                    //Total Price
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 1),
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1))),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Grand Total: \$$total",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))),
                    // Button
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 173,
                            child: Expanded(
                                child: ButtonWidget(
                                    icon: Icons.cancel,
                                    colorIcon: Colors.white,
                                    text: "Clear Cart",
                                    fontSizeButton: 14,
                                    color: Colors.white,
                                    backGroundColor: Colors.red,
                                    heightButton: 35,
                                    handleOnPressed: () =>
                                        clearCart(context.read<CartCubit>()))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 173,
                            child: Expanded(
                                child: ButtonWidget(
                                    icon: "images/icons/cart.svg",
                                    colorIcon: Colors.white,
                                    text: "Check out",
                                    fontSizeButton: 14,
                                    color: Colors.white,
                                    backGroundColor:
                                        const Color.fromRGBO(56, 193, 144, 1),
                                    heightButton: 35,
                                    handleOnPressed: () => checkOut(products,
                                        total, context.read<CartCubit>()))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26, bottom: 142),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 173,
                            child: Expanded(
                                child: ButtonWidget(
                                    icon: "images/icons/go_back.svg",
                                    widthIcon: 16,
                                    heightIcon: 16,
                                    colorIcon: Colors.white,
                                    text: "Continue Shopping",
                                    fontSizeButton: 14,
                                    color: Colors.white,
                                    backGroundColor:
                                        const Color.fromRGBO(56, 193, 144, 1),
                                    heightButton: 35,
                                    handleOnPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductsPage(),
                                          ));
                                    })),
                          )
                        ],
                      ),
                    )
                  ]));
            })),
        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  SizedBox(height: 10),
                  Text("Handle Check Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              ),
            ),
          )
      ],
    );
  }

  Future<void> clearCart(CartCubit cartCubit) async {
    try {
      await cartCubit.clearCart();
      if (!mounted) return;
      showNotification(context, "Clear cart is success");
    } catch (e) {
      showNotification(context, "Clear cart is failure");
    }
  }

  void goLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  Future<void> checkOut(
      List<CartProductModel> products, int total, CartCubit cartCubit) async {
    if (products.isEmpty) {
      return showNotification(context, "Cart is empty!!!");
    }
    String token = await LocalStorage.getValue(Constants.token);
    if (token.isEmpty) {
      if (!mounted) return;
      return showAlert(context, "Thất bại",
          "Bạn phải đăng nhập để đặt hàng!!!", "Đồng ý", goLoginPage, isHaveCancelButton: true);
    }
    try {
      setState(() {
        isLoading = true;
      });

      await orderApi.addOrder(products, total);
      await cartCubit.clearCart();
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      showNotification(context, "Checkout is success");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      showAlert(context, "Thất bại",
          "Phiên đăng nhập đã hết hạn. Bạn phải đăng nhập lại để đặt hàng!!!", "Đồng ý", goLoginPage, isHaveCancelButton: true);
    }
  }
}
