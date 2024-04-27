import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/presentation/cart_screen/widgets/cart_productitem.dart';
import 'package:crocs_club/application/presentation/checkout_screen/checkout_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  return const Center(child: CircularProgressIndicator());
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const CheckoutScreen(),
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
                  return const Center(
                    child: SubHeadingTextWidget(title: 'Try again'),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (productState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productState is ProductError) {
            return const Center(
              child: SubHeadingTextWidget(title: 'could not fetch product'),
            );
          } else {
            return const Center(
                child: SubHeadingTextWidget(title: 'Unknown product state'));
          }
        },
      ),
    );
  }
}
