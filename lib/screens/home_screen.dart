import 'package:ban_hang/widgets/product_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../api/product_api.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../models/product_model.dart';
import '../utils/show_notification.dart';
import '../widgets/main_navigation_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

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
                        Text("Products",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("All available products in our store",
                            style: TextStyle(fontSize: 16))
                      ],
                    ))
                  ],
                ),
              ),
            )),
          ),
          bottomNavigationBar: const MainNavigation(pageName: "Products"),
          body: const Products(),
        ),
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _Products();
}

class _Products extends State<Products> {
  final productApi = ProductApi();
  List<ProductModel> products = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 36, top: 12),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (_, __) {
          return ListView.builder(
              controller: scrollController,
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return loadingIndicator();
                }
                final product = products[index];
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50,
                      child: FadeInAnimation(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Product(
                            productId: product.id,
                            urlImage: product.image,
                            productName: product.name,
                            productPrice: product.price,
                            productStock: product.quantity,
                          ),
                        ),
                      ),
                    ));
              });
        },
      ),
    );
  }

  Widget loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const SizedBox
                .shrink(), // Hiển thị một SizedBox khi không loading
      ),
    );
  }

  Future<void> getProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<ProductModel> data = await productApi.getProducts(page);
      if (data.isNotEmpty) {
        setState(() {
          products.addAll(data);
          page += 1;
        });
      }
    } catch (e) {
      if (!mounted) return;
      showNotification(context, "Get products is failure!!!");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
