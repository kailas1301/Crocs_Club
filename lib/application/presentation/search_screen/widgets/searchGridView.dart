import 'package:crocs_club/application/business_logic/search/bloc/search_bloc.dart';
import 'package:crocs_club/application/presentation/products/widgets/product_card_widget.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedProductGridView extends StatelessWidget {
  const SearchedProductGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const LoadingAnimationStaggeredDotsWave();
          } else if (state is SearchLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: state.searchProductlist.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.35,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) =>
                  ProductCard(product: state.searchProductlist[index]),
            );
          } else if (state is SearchError) {
            return const Center(
              child: SubHeadingTextWidget(
                title: 'No Product found',
                textColor: kDarkGreyColour,
                textsize: 16,
              ),
            );
          } else {
            return const Center(
              child: SubHeadingTextWidget(
                title: 'Search For Products',
                textColor: kDarkGreyColour,
                textsize: 16,
              ),
            );
          }
        },
      ),
    );
  }
}
