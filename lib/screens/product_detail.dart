import 'package:ban_hang/models/product_model.dart';
import 'package:ban_hang/screens/products.dart';
import 'package:ban_hang/widgets/button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../api/product_api.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../models/cart_product_model.dart';
import '../utils/show_notification.dart';
import '../widgets/main_navigation.dart';
import '../widgets/product_detail_infor.dart';

class ProductDeatilPage extends StatelessWidget {
  const ProductDeatilPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int idProduct = ModalRoute.of(context)?.settings.arguments as int;

    return MaterialApp(
      home: BlocProvider(
        create: (context) => CartCubit(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1), // Đặt màu nền cho AppBar
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Row(
                      children: [Expanded(child: Column(children: [
                        Text("Products", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      ],))],
                    ),
                  ),
                )
            ),
          ),
          bottomNavigationBar: const MainNavigation(),
          body: Container(
            margin: const EdgeInsets.only(top: 16),
            child: ProductDetail(idProduct: idProduct),
          ),
        ),
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.idProduct});

  final int idProduct;

  @override
  State<ProductDetail> createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail> {
  final productApi = ProductApi();
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: product == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.network(product!.image, width: 228),
                  ),
                  Text(product!.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        product!.description,
                        style: const TextStyle(fontSize: 16),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 16.1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Item Code:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 0),
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFFF0AD4E),
                            ),
                            child: Text(product!.id.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      )),
                  ProductDetailInfor(
                      title: "Manufacturer",
                      description: product!.manufacturer),
                  ProductDetailInfor(
                      title: "Category", description: product!.category),
                  ProductDetailInfor(
                      title: "Available units in stock",
                      description: product!.quantity),
                  ProductDetailInfor(
                      title: "Price", description: "${product!.price} USD"),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.1, left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                  icon: "images/icons/go_back.svg",
                                  widthIcon: 18,
                                  heightIcon: 17,
                                  text: "Back",
                                  fontSizeButton: 16,
                                  color: Colors.white,
                                  backGroundColor: const Color(0xFF5CB85C),
                                  handleOnPressed: () =>
                                      backProductsPage(context)),
                            ),
                            const SizedBox(width: 25.47),
                            Expanded(child: BlocBuilder<CartCubit, CartState>(
                                builder: (context, _) {
                              return ButtonWidget(
                                  icon: "images/icons/cart.svg",
                                  text: "Order Now",
                                  fontSizeButton: 16,
                                  color: Colors.white,
                                  backGroundColor: const Color(0xFFF0AD4E),
                                  handleOnPressed: () => orderNow(context.read<CartCubit>()));
                            }))
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ));
  }

  Future<void> getProduct() async {
    try {
      ProductModel data = await productApi.getProduct(widget.idProduct);
      setState(() {
        product = data;
      });
    } catch (e) {
      if (!mounted) return;
      showNotification(context, "Get product is failure!!!");
    }
  }

  void backProductsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductsPage(),
        ));
  }

  Future<void> orderNow(CartCubit cartCubit) async {
    final cartProduct = CartProductModel(
        id: product!.id,
        name: product!.name,
        unitPrice: product!.price,
        quantity: 1,
        price: product!.price);
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
