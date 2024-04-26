import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/presentation/checkout_screen/checkout_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/cart_from_api_model.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    return Scaffold(
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
                            SubHeadingTextWidget(
                              title: 'Subtotal: ₹${_calculateSubtotal(cart)}',
                              textColor: kGreenColour,
                              textsize: 18,
                            ),
                            kSizedBoxH20,
                            ElevatedButtonWidget(
                              buttonText: 'Checkout',
                              textsize: 16,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen(),
                                ));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (state is CartError) {
                  return Center(
                    child: Text('Error: ${state.errorMessage}'),
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
              child: Text('could not fetch product'),
            );
          } else {
            return const Center(child: Text('Unknown product state'));
          }
        },
      ),
    );
  }

  int _calculateSubtotal(CartFromApiModel cart) {
    return cart.items.fold(0, (subtotal, item) => subtotal + item.totalPrice);
  }
}

class ProductCartItem extends StatelessWidget {
  const ProductCartItem({
    super.key,
    required this.product,
    required this.item,
    required this.cart,
  });

  final ProductFromApi product;
  final CartItem item;
  final CartFromApiModel cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kwhiteColour,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubHeadingTextWidget(
                    title: item.productName.toUpperCase(),
                    textColor: kDarkGreyColour,
                    textsize: 18,
                  ),
                  SubHeadingTextWidget(
                    title: 'Price: ₹${item.price}',
                    textColor: kDarkGreyColour,
                    textsize: 15,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: kPrimaryDarkColor,
                    ),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(
                        context,
                      ).add(
                        DeleteFromCartEvent(
                          cartId: cart.id,
                          itemId: item.productId,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: product.image[0],
                      imageBuilder: (context, imageProvider) => Container(
                        width: screenWidth * .2,
                        height: screenWidth * .3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  kSizedBoxW10,
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          size: 45,
                          color: kDarkGreyColour,
                        ),
                        onPressed: () {
                          if (item.quantity == 1) {
                            BlocProvider.of<CartBloc>(context).add(
                                DeleteFromCartEvent(
                                    cartId: cart.id, itemId: item.productId));
                          } else {
                            BlocProvider.of<CartBloc>(context).add(
                              UpdateCartQuantityEvent(
                                inventoryId: item.productId,
                                quantity: item.quantity - 1,
                                cartId: cart.id,
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          color: kDarkGreyColour,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 25),
                          child: SubHeadingTextWidget(
                              textColor: kwhiteColour,
                              textsize: 15,
                              title: item.quantity.toString()),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          size: 45,
                          color: kDarkGreyColour,
                        ),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(
                            UpdateCartQuantityEvent(
                              inventoryId: item.productId,
                              quantity: item.quantity + 1,
                              cartId: cart.id,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SubHeadingTextWidget(
                title: 'Total: ₹${item.totalPrice}',
                textColor: kGreenColour,
                textsize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
