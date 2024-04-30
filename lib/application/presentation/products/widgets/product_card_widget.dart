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

class ProductCard extends StatelessWidget {
  final ProductFromApi product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WishlistBloc>().add(FetchWishlistEvent());

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetail(product: product),
        )),
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
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: product.image[0],
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: screenWidth * .3,
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
                    placeholder: (context, url) =>
                        const Center(child: ThreeDotLoadingAnimation()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingTextWidget(title: product.productName),
                          BlocBuilder<WishlistBloc, WishlistState>(
                            builder: (context, state) {
                              if (state is WishlistLoading) {
                                return const LoadingAnimationStaggeredDotsWave();
                              } else {
                                final isInWishlist = state is WishlistLoaded &&
                                    state.wishlist.any((item) =>
                                        item.inventoryId == product.id);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingTextWidget(
                              textColor: kGreenColour,
                              title: '₹ ${product.price.floor().toString()}'),
                          SubHeadingTextWidget(
                            title: 'Size:${product.size}',
                            textColor: kDarkGreyColour,
                          ),
                        ],
                      ),
                    ],
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
