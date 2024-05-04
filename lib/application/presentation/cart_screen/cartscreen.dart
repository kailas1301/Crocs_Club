import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/presentation/cart_screen/widgets/cart_productitem.dart';
import 'package:crocs_club/application/presentation/checkout_screen/checkout_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/checkout_product.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    return Scaffold(
      // appbar section
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(
          title: 'My Cart',
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productState) {
          if (productState is ProductLoaded) {
            return BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CartLoading) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  );
                } else if (state is CartLoaded) {
                  final cart = state.cartFromApi;
                  if (cart.items.isEmpty) {
                    return const Center(
                      child: SubHeadingTextWidget(
                        title: 'No items in the cart',
                        textColor: kDarkGreyColour,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              final item = cart.items[index];
                              final product = productState.products.firstWhere(
                                (product) => product.id == item.productId,
                              );
                              return ProductCartItem(
                                  product: product, item: item, cart: cart);
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            kSizedBoxH10,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SubHeadingTextWidget(
                                title:
                                    'Subtotal: ₹${cart.items.fold(0, (subtotal, item) => subtotal + item.totalPrice)}',
                                textColor: kGreenColour,
                                textsize: 18,
                              ),
                            ),
                            kSizedBoxH20,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButtonWidget(
                                width: screenWidth * .6,
                                buttonText: 'Checkout',
                                textsize: 16,
                                onPressed: () {
                                  // Convert CartItem objects to CheckOutProductModel objects
                                  List<CheckOutProductModel> checkOutProducts =
                                      cart.items.map((item) {
                                    final product =
                                        productState.products.firstWhere(
                                      (product) => product.id == item.productId,
                                    );

                                    return CheckOutProductModel(
                                      imageUrl: product.image[
                                          0], // Assuming imageUrl is a property of ProductFromApi
                                      name: product.productName,
                                      quantity: item.quantity,
                                      price: product.price,
                                      finalPrice: item.totalPrice,
                                      size: product
                                          .size, // Assuming size is a property of ProductFromApi
                                    );
                                  }).toList();

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      checkoutProducts: checkOutProducts,
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (state is CartError) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: kAppPrimaryColor,
                      size: 40,
                    ),
                  );
                }
              },
            );
          } else if (productState is ProductLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: kAppPrimaryColor,
                size: 40,
              ),
            );
          } else if (productState is ProductError) {
            return const Center(
              child: SubHeadingTextWidget(title: 'could not fetch product'),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: kAppPrimaryColor,
                size: 40,
              ),
            );
          }
        },
      ),
    );
  }
}
