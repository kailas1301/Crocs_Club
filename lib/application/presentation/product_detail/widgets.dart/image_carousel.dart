import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crocs_club/application/presentation/product_detail/product_detail.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCarouselWidget extends StatelessWidget {
  const ImageCarouselWidget({
    super.key,
    required this.product,
  });

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: product.image.length,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              height: MediaQuery.of(context).size.height / 3,
              imageUrl: product.image[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => const ThreeDotLoadingAnimation(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
            Provider.of<CarouselIndicatorState>(context, listen: false)
                .setCurrentIndex(index);
          },
        ),
      ),
    );
  }
}
