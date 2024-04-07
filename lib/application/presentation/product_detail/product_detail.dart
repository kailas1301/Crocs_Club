import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTextWidget(title: product.productName.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                            top: Radius.circular(12)),
                        child: CachedNetworkImage(
                          height: screenHeight * .5,
                          imageUrl: product.image[0],
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
              ),
              kSizedBoxH30,
              kSizedBoxH20,
              Container(
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingTextWidget(
                            title: product.productName.toUpperCase(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      SubHeadingTextWidget(
                        textColor: kDarkGreyColour,
                        title: 'Size: ${product.size}',
                      ),
                      kSizedBoxH10,
                      SubHeadingTextWidget(
                        textColor: kGreenColour,
                        title: 'Price: ₹${product.price.floor().toString()}',
                      ),
                      kSizedBoxH30,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kblackColour,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 203, 202, 202)
                                    .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          height: screenHeight * .085,
                          width: screenWidth * .65,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SubHeadingTextWidget(
                                  title: 'Add to Cart',
                                  textColor: kwhiteColour,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.shopping_bag,
                                      color: kwhiteColour,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      kSizedBoxH30
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
