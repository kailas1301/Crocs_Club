import 'package:crocs_club/application/business_logic/search/bloc/search_bloc.dart';
import 'package:crocs_club/application/presentation/user_home_screen/user_home_scrn.dart';
import 'package:crocs_club/data/debouncer/debouncer.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/loading_animations.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(ProductSearchEvent(query: ""));
    final TextEditingController searchController = TextEditingController();
    final Debouncer debouncer =
        Debouncer(delay: const Duration(milliseconds: 300));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Search'),
      ),
      body: Column(
        children: [
          // Search Bar with Debouncer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: searchController,
              decoration: InputDecoration(
                labelStyle: GoogleFonts.roboto(
                    color: kDarkGreyColour,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hintStyle: GoogleFonts.roboto(
                    color: kDarkGreyColour,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                labelText: 'Search',
                hintText: 'Enter product name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kAppPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kAppPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kAppPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 16.0),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  debouncer.run(() {
                    print("product search event is called");
                    BlocProvider.of<SearchBloc>(context)
                        .add(ProductSearchEvent(query: value));
                  });
                } else {
                  BlocProvider.of<SearchBloc>(context)
                      .add(ProductSearchEvent(query: value));
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const LoadingAnimationStaggeredDotsWave();
                } else if (state is SearchLoaded) {
                  return ListView.builder(
                    itemCount: state.searchProductlist.length,
                    itemBuilder: (context, index) {
                      final product = state.searchProductlist[index];
                      return ProductCardWidget(
                        product: product,
                      );
                    },
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
          ),
        ],
      ),
    );
  }
}
