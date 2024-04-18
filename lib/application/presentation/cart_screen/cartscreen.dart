import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/cart_from_api_model.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SubHeadingTextWidget(
          title: 'My Cart',
          textColor: kDarkGreyColour,
          textsize: 20,
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemDeleted) {
            showCustomSnackbar(context, 'Product was removed from the cart',
                kGreenColour, kwhiteColour);
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cart = state.cartFromApi;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
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
                            padding: const EdgeInsets.only(
                                top: 25, left: 25, bottom: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubHeadingTextWidget(
                                      title: item.productName.toUpperCase(),
                                      textColor: kDarkGreyColour,
                                      textsize: 18,
                                    ),
                                    kSizedBoxH10,
                                    SubHeadingTextWidget(
                                      title: 'Price: ₹${item.price}',
                                      textColor: kDarkGreyColour,
                                    ),
                                    kSizedBoxH10,
                                    Row(
                                      children: [
                                        const SubHeadingTextWidget(
                                          title: 'Quantity',
                                          textColor: kDarkGreyColour,
                                        ),
                                        kSizedBoxW20,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kAppPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: const Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_drop_up,
                                              size: 30,
                                              color: kwhiteColour,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        kSizedBoxW10,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kAppPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                                title:
                                                    item.quantity.toString()),
                                          ),
                                        ),
                                        kSizedBoxW10,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kAppPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: const Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                              color: kwhiteColour,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        kSizedBoxW20,
                                      ],
                                    ),
                                    kSizedBoxH20,
                                    SubHeadingTextWidget(
                                      title: 'Total: ₹${item.totalPrice}',
                                      textColor: kGreenColour,
                                      textsize: 18,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: kPrimaryDarkColor,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context).add(
                                        DeleteFromCartEvent(
                                            cartId: cart.id,
                                            itemId: item.productId));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
                          // TODO: Implement checkout functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  int _calculateSubtotal(CartFromApiModel cart) {
    return cart.items.fold(0, (subtotal, item) => subtotal + item.totalPrice);
  }
}
