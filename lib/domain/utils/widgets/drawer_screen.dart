import 'package:crocs_club/application/presentation/favourites_page/favourite_page.dart';
import 'package:crocs_club/application/presentation/profile_screen/profile_screen.dart';
import 'package:crocs_club/application/presentation/wallet/wallet_screen.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/functions/functions.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          kSizedBoxH30,
          kSizedBoxH30,
          ListTile(
            leading:
                const Icon(Icons.person), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour, title: 'Profile', textsize: 15),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ));
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.favorite), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              title: 'Favourites',
              textsize: 15,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FavouriteScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons
                .currency_rupee_rounded), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              title: 'Wallet',
              textsize: 15,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WalletScreen(),
              ));
            },
          ),
          ListTile(
              leading:
                  const Icon(Icons.logout), // Leading widget for this list tile
              title: const SubHeadingTextWidget(
                  textColor: kDarkGreyColour, title: 'Log Out', textsize: 15),
              onTap: () {
                userlogout(context);
              }),
          ListTile(
            leading:
                const Icon(Icons.share), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour, title: 'Share', textsize: 15),
            onTap: () {
              // Handle navigation to settings
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.info), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
                textColor: kDarkGreyColour, title: 'About Us', textsize: 15),
            onTap: () {
              // Handle navigation to settings
            },
          ),
        ],
      ),
    );
  }
}
