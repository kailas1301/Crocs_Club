import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/cart_from_api_model.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
