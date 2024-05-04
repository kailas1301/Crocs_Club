import 'package:crocs_club/application/business_logic/search/bloc/search_bloc.dart';
import 'package:crocs_club/application/presentation/search_screen/widgets/searchGridView.dart';
import 'package:crocs_club/application/presentation/search_screen/widgets/searchtextfield.dart';
import 'package:crocs_club/data/debouncer/debouncer.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search Bar with Debouncer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchFieldWidget(
                  searchController: searchController, debouncer: debouncer),
            ),
            const SizedBox(height: 20),
            const SearchedProductGridView(),
          ],
        ),
      ),
    );
  }
}
