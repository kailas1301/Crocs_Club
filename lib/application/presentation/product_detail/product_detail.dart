import 'package:crocs_club/application/business_logic/cart/bloc/cart_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/application/presentation/cart_screen/cartscreen.dart';
import 'package:crocs_club/application/presentation/product_detail/widgets.dart/image_carousel.dart';
import 'package:crocs_club/application/presentation/product_detail/widgets.dart/productdetails.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocs_club/domain/models/product.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
          centerTitle: true,
          title: AppBarTextWidget(
            title: product.productName,
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
                        kSizedBoxH20,
                        ImageCarouselWidget(product: product),
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
                        kSizedBoxH20,
                        ProductDetails(product: product),
                      ],
                    );
                  }),
                ),
              ),
            )));
  }
}
