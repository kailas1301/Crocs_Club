import 'package:crocs_club/application/presentation/favourites_page/favourite_page.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu_outlined),
        ),
      ),
      title: const AppBarTextWidget(
        title: 'Step Mate Shop',
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const FavouriteScreen(),
            ));
          },
          icon: const Icon(
            Icons.favorite,
            color: kRedColour,
          ),
        ),
      ],
    );
  }
}
