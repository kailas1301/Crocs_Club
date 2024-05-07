import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/presentation/products/widgets/product_card_widget.dart';
import 'package:crocs_club/application/presentation/search_screen/search_screen.dart';
import 'package:crocs_club/domain/models/category_model.dart';
import 'package:crocs_club/domain/models/product.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:crocs_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ));
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<dynamic>(
            onSelected: (value) {
              if (value is CategoryModel) {
                BlocProvider.of<ProductBloc>(context)
                    .add(SortProductsByCategory(id: value.id));
              } else if (value == 'Low to High') {
                BlocProvider.of<ProductBloc>(context)
                    .add(SortProductsByPriceLowToHigh());
              } else if (value == 'High to Low') {
                BlocProvider.of<ProductBloc>(context)
                    .add(SortProductsByPriceHighToLow());
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<dynamic>>[
                ..._buildCategoryMenuItems(context),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'Low to High',
                  child: Text('Price: Low to High'),
                ),
                const PopupMenuItem<String>(
                  value: 'High to Low',
                  child: Text('Price: High to Low'),
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProductLoading) {
                return SizedBox(
                  height: screenHeight,
                  child:
                      const Center(child: LoadingAnimationStaggeredDotsWave()),
                );
              } else if (state is ProductLoaded) {
                final List<ProductFromApi> shuffledProductList =
                    List.from(state.products)..shuffle();
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: shuffledProductList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.35,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) =>
                      ProductCard(product: shuffledProductList[index]),
                );
              } else if (state is ProductError) {
                return SizedBox(
                  height: screenHeight,
                  child: const Center(
                    child: SubHeadingTextWidget(title: 'No products available'),
                  ),
                );
              } else {
                return SizedBox(
                  height: screenHeight,
                  child: const Center(
                    child: SubHeadingTextWidget(title: 'No products available'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildCategoryMenuItems(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final state = productBloc.state;

    if (state is ProductLoaded &&
        state.categories != null &&
        state.categories!.isNotEmpty) {
      final categories = state.categories!;
      return categories.map((category) {
        return PopupMenuItem<CategoryModel>(
          value: category,
          child: Text(category.category),
        );
      }).toList();
    }

    return [];
  }
}
