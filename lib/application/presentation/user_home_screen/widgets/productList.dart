import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/application/presentation/product_detail/product_detail.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildProductList(List<ProductFromApi> products) {
  List<ProductFromApi> productList = products.reversed.toList();
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: productList.length,
    itemBuilder: (context, index) {
      final product = productList[index];
      return ProductCardWidget(product: product);
    },
  );
}

Widget buildProductListLessThanThousan(List<ProductFromApi> products) {
  List<ProductFromApi> productList =
      products.where((product) => product.price <= 1000).toList();
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: productList.length,
    itemBuilder: (context, index) {
      final product = productList[index];
      return ProductCardWidget(product: product);
    },
  );
}

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: screenWidth * 0.5,
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * .18,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image[0],
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          // height: screenHeight * .18,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => const Center(
                          child: LoadingAnimationStaggeredDotsWave()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                kSizedBoxH10,
                SubHeadingTextWidget(
                  title: product.productName,
                  textsize: 17,
                ),
                kSizedBoxH10,
                SubHeadingTextWidget(
                  title: 'Size: ${product.size}',
                  textColor: kDarkGreyColour,
                  textsize: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceTextWidget(
                      title: 'Price: ₹${product.price.floor()}',
                      textColor: kGreenColour,
                      textsize: 16,
                    ),
                    BlocBuilder<WishlistBloc, WishlistState>(
                      builder: (context, state) {
                        if (state is WishlistLoading) {
                          return const LoadingAnimationStaggeredDotsWave();
                        } else {
                          final isInWishlist = state is WishlistLoaded &&
                              state.wishlist.any(
                                  (item) => item.inventoryId == product.id);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
