import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocs_club/application/presentation/product_detail/product_detail.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductFromApi product;

  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      )),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15),
          // ),
          // elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: product.image[0],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                          child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shopping_cart))
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubHeadingTextWidget(title: product.productName)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
