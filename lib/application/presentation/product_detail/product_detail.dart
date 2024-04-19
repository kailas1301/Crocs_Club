import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/models/add_to_cart_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    context.read<WishlistBloc>().add(FetchWishlistEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SubHeadingTextWidget(
          title: product.productName,
          textColor: kDarkGreyColour,
          textsize: 20,
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAdded) {
            showCustomSnackbar(
                context, 'Product added to cart', kGreenColour, kwhiteColour);
          } else if (state is CartAlreadyExists) {
            showCustomSnackbar(context, 'Product already exixts in cart',
                kRedColour, kwhiteColour);
          } else if (state is CartError) {
            showCustomSnackbar(
                context, state.errorMessage, kRedColour, kwhiteColour);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kSizedBoxH30,
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: PageView.builder(
                    itemCount: product.image.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.image[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                kSizedBoxH30,
                kSizedBoxH30,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SubHeadingTextWidget(
                              textColor: kblackColour,
                              textsize: 18,
                              title: product.productName,
                            ),
                            BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (context, state) {
                                if (state is WishlistLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final isInWishlist =
                                      state is WishlistLoaded &&
                                          state.wishlist.any((item) =>
                                              item.inventoryId == product.id);
                                  return IconButton(
                                    onPressed: () {
                                      final wishlistBloc =
                                          BlocProvider.of<WishlistBloc>(
                                              context);
                                      if (isInWishlist) {
                                        wishlistBloc.add(
                                          RemoveFromWishlistEvent(product.id),
                                        );
                                      } else {
                                        wishlistBloc.add(
                                          AddToWishlistEvent(product.id),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      isInWishlist
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isInWishlist ? Colors.red : null,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        kSizedBoxH10,
                        SubHeadingTextWidget(
                            textColor: kDarkGreyColour,
                            textsize: 14,
                            title: 'Size: ${product.size}'),
                        kSizedBoxH10,
                        SubHeadingTextWidget(
                            textColor: kGreenColour,
                            title:
                                'Price: ₹${product.price.floor().toString()}'),
                        kSizedBoxH30,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButtonWidget(
                            width: screenWidth * .4,
                            buttonText: 'Add To Cart',
                            onPressed: () {
                              final cartBloc =
                                  BlocProvider.of<CartBloc>(context);
                              cartBloc.add(
                                AddToCartEvent(
                                  cart: CartAddingModel(
                                    productsId: product.id,
                                    quantity: 1, // or any quantity you want
                                  ),
                                ),
                              );
                              print('Add to cart was pressed');
                            },
                          ),
                        ),
                        kSizedBoxH30,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
