import 'package:crocs_club/application/business_logic/search/bloc/search_bloc.dart';
import 'package:crocs_club/data/debouncer/debouncer.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.searchController,
    required this.debouncer,
  });

  final TextEditingController searchController;
  final Debouncer debouncer;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.name,
      controller: searchController,
      decoration: InputDecoration(
        labelStyle: GoogleFonts.roboto(
            color: kDarkGreyColour, fontSize: 14, fontWeight: FontWeight.w600),
        hintStyle: GoogleFonts.roboto(
            color: kDarkGreyColour, fontSize: 14, fontWeight: FontWeight.w600),
        labelText: 'Search',
        hintText: 'Enter product name...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: kAppPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kAppPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kAppPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          debouncer.run(() {
            BlocProvider.of<SearchBloc>(context)
                .add(ProductSearchEvent(query: value));
          });
        } else {
          BlocProvider.of<SearchBloc>(context)
              .add(ProductSearchEvent(query: value));
        }
      },
    );
  }
}
