
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/add_to_cart_model.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
                    return const LoadingAnimationStaggeredDotsWave();
                  } else {
                    final isInWishlist = state is WishlistLoaded &&
                        state.wishlist
                            .any((item) => item.inventoryId == product.id);
                    return IconButton(
                      onPressed: () {
                        final wishlistBloc =
                            BlocProvider.of<WishlistBloc>(context);
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
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
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
          PriceTextWidget(
              textColor: kGreenColour,
              title: 'Price: ₹${product.price.floor().toString()}'),
          kSizedBoxH30,
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButtonWidget(
              width: screenWidth * .4,
              buttonText: 'Add To Cart',
              onPressed: () {
                final cartBloc = BlocProvider.of<CartBloc>(context);
                cartBloc.add(
                  AddToCartEvent(
                    cart: CartAddingModel(
                      productsId: product.id,
                      quantity: 1, // or any quantity you want
                    ),
                  ),
                );
              },
            ),
          ),
          kSizedBoxH30,
        ],
      ),
    );
  }
}
