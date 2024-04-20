import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:crocs_club/application/presentation/products/widgets/product_card_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Favourites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, wishlistState) {
              if (wishlistState is WishlistLoaded) {
                return BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, productState) {
                    if (productState is ProductLoaded) {
                      final favoriteProducts = productState.products
                          .where((product) => wishlistState.wishlist
                              .any((item) => item.inventoryId == product.id))
                          .toList();

                      return favoriteProducts.isEmpty
                          ? const Center(child: Text('No favorite products'))
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: favoriteProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.6,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: favoriteProducts[index],
                                );
                              },
                            );
                    } else {
                      print(productState);
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                print(wishlistState);
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
