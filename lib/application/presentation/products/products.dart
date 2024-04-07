import 'package:crocs_club/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocs_club/application/presentation/products/widgets/product_card_widget.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    return Scaffold(
      appBar: AppBar(
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductLoaded) {
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) =>
                        ProductCard(product: state.products[index]));
              } else if (state is ProductError) {
                return const Center(
                  child: SubHeadingTextWidget(title: 'No products available'),
                );
              } else {
                return const Center(
                  child: SubHeadingTextWidget(title: 'No products available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
