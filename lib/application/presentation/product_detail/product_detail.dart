import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/models/add_to_cart_model.dart';
import 'package:provider/provider.dart';

class CarouselIndicatorState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

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
                showCustomSnackbar(context, 'Product added to cart',
                    kGreenColour, kwhiteColour);
              } else if (state is CartAlreadyExists) {
                showCustomSnackbar(context, 'Product already exixts in cart',
                    kRedColour, kwhiteColour);
              } else if (state is CartError) {
                showCustomSnackbar(
                    context, state.errorMessage, kRedColour, kwhiteColour);
              }
            },
            child: ChangeNotifierProvider(
              create: (context) =>
                  CarouselIndicatorState(), // Step 2: Provide the state
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Consumer<CarouselIndicatorState>(
                      // Step 3: Consume the state
                      builder: (context, indicatorState, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: CarouselSlider.builder(
                            itemCount: product.image.length,
                            itemBuilder: (context, index, realIndex) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: CachedNetworkImage(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  imageUrl: product.image[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const ThreeDotLoadingAnimation(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              onPageChanged: (index, reason) {
                                // Update the current index when page changes
                                Provider.of<CarouselIndicatorState>(context,
                                        listen: false)
                                    .setCurrentIndex(index);
                              },
                            ),
                          ),
                        ),
                        // Step 4: Add indicator widgets
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            product.image.length,
                            (index) => Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: indicatorState.currentIndex == index
                                    ? Colors.blueAccent
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          final isInWishlist =
                                              state is WishlistLoaded &&
                                                  state.wishlist.any((item) =>
                                                      item.inventoryId ==
                                                      product.id);
                                          return IconButton(
                                            onPressed: () {
                                              final wishlistBloc =
                                                  BlocProvider.of<WishlistBloc>(
                                                      context);
                                              if (isInWishlist) {
                                                wishlistBloc.add(
                                                  RemoveFromWishlistEvent(
                                                      product.id),
                                                );
                                              } else {
                                                wishlistBloc.add(
                                                  AddToWishlistEvent(
                                                      product.id),
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              isInWishlist
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isInWishlist
                                                  ? Colors.red
                                                  : null,
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
                                            quantity:
                                                1, // or any quantity you want
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
                    );
                  }),
                ),
              ),
            )));
  }
}
