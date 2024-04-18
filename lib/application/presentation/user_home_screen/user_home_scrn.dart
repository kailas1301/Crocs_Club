import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/business_logic/profile/bloc/profile_bloc.dart';
import 'package:crocs_club/application/presentation/product_detail/product_detail.dart';
import 'package:crocs_club/application/presentation/user_home_screen/widgets/home_app_bar.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/drawer_screen.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    BlocProvider.of<ProfileBloc>(context).add(ProfileFetched());
    final currentTime = DateTime.now();
    String greeting = getGreeting(currentTime.hour);

    return Scaffold(
      backgroundColor: kwhiteColour,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HomeScreenAppBar(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return SubHeadingTextWidget(
                        textColor: kDarkGreyColour,
                        title: '$greeting, ${state.profileData['name']}');
                  } else {
                    return SubHeadingTextWidget(
                      title: greeting,
                    );
                  }
                },
              ),
            ),
            kSizedBoxH20,
            buildCarouselSlider(),
            kSizedBoxH10,
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: SubHeadingTextWidget(
                title: 'Latest Products',
                textColor: kDarkGreyColour,
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return buildProductList(state.products);
                  } else if (state is ProductError) {
                    return const Center(child: Text('Failed to load products'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerScreen(),
    );
  }

  Widget buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        buildOfferItem('', '', Colors.red),
        buildOfferItem('', '', const Color.fromARGB(255, 61, 99, 205)),
        buildOfferItem('', '', const Color.fromARGB(255, 122, 155, 37)),
      ],
    );
  }

  Widget buildOfferItem(String imageUrl, String offerText, Color color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
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
      child: const Column(
        children: [],
      ),
    );
  }

  Widget buildProductList(List<ProductFromApi> products) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardWidget(product: product);
      },
    );
  }
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
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: screenWidth * 0.5, // Set width as per your requirement
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image[0],
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: screenWidth * .4,
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
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                kSizedBoxH10,
                SubHeadingTextWidget(
                  title: product.productName,
                  textsize: 17,
                ),
                SubHeadingTextWidget(
                  title: 'Size: ${product.size}',
                  textColor: kDarkGreyColour,
                  textsize: 16,
                ),
                SubHeadingTextWidget(
                  title: 'Price: ${product.price.floor()}',
                  textColor: kGreenColour,
                  textsize: 16,
                ),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart),
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
